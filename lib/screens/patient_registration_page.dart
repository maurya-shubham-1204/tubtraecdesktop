import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/ui_bits.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({super.key, this.onNavigate});

  final ShellNavigate? onNavigate;

  @override
  State<PatientRegistrationPage> createState() => _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  int _step = 0; // 0 = patient, 1 = billing
  final _patientFormKey = GlobalKey<FormState>();

  final _prefix = TextEditingController(text: 'Mr.');
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _age = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _remark = TextEditingController();
  final _paid = TextEditingController(text: '0');
  final _discPct = TextEditingController(text: '0');
  final _discAmt = TextEditingController(text: '0');
  final _testSearch = TextEditingController();
  String _sex = 'Male';
  String _payMethod = 'cash'; // cash | upi | pay_later
  final _selected = <int>{};
  /// Editable line prices keyed by test id (capped at catalog price).
  final _linePrices = <int, double>{};
  int? _doctorId;
  bool _saving = false;
  bool _updatingDisc = false;
  bool _autovalidate = false;

  @override
  void dispose() {
    _prefix.dispose();
    _first.dispose();
    _last.dispose();
    _age.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    _remark.dispose();
    _paid.dispose();
    _discPct.dispose();
    _discAmt.dispose();
    _testSearch.dispose();
    super.dispose();
  }

  void _resetForm() {
    _first.clear();
    _last.clear();
    _age.clear();
    _phone.clear();
    _email.clear();
    _address.clear();
    _remark.clear();
    _discPct.text = '0';
    _discAmt.text = '0';
    _paid.text = '0';
    _payMethod = 'cash';
    _selected.clear();
    _linePrices.clear();
    _testSearch.clear();
    _doctorId = null;
    _sex = 'Male';
    _prefix.text = 'Mr.';
    _step = 0;
    _autovalidate = false;
    _patientFormKey.currentState?.reset();
  }

  /// Same rules as web `RegistrationRequest` + HTML required fields.
  /// Works on step 2 too (patient Form may not be mounted).
  String? _patientValidationError({required List<Doctor> doctors}) {
    final first = _first.text.trim();
    if (first.isEmpty) return 'First name is required';
    if (first.length < 3) return 'First name must be at least 3 characters';

    final ageText = _age.text.trim();
    if (ageText.isEmpty) return 'Age is required';
    final age = double.tryParse(ageText);
    if (age == null) return 'Age must be a number';
    if (age <= 0 || age > 150) return 'Enter a valid age';

    final mobile = _phone.text.trim();
    if (mobile.isEmpty) return 'Mobile is required';
    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) return 'Enter 10 digit mobile';

    final email = _email.text.trim();
    if (email.isNotEmpty && !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email';
    }

    if (_sex.trim().isEmpty) return 'Gender is required';

    if (doctors.isEmpty) return 'Add a referring doctor first (Doctors screen)';
    if (_doctorId == null) return 'Referred by is required';

    return null;
  }

  bool _validatePatient({required List<Doctor> doctors, bool showFormErrors = true}) {
    final error = _patientValidationError(doctors: doctors);

    // When patient step is visible, also paint field-level errors.
    if (showFormErrors && _patientFormKey.currentState != null) {
      setState(() => _autovalidate = true);
      _patientFormKey.currentState!.validate();
    }

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return false;
    }
    return true;
  }

  void _goBilling(List<Doctor> doctors) {
    if (!_validatePatient(doctors: doctors)) return;
    setState(() => _step = 1);
  }

  void _syncPaidFromPayable(double payable) {
    if (_payMethod == 'pay_later') {
      _paid.text = '0';
    } else {
      _paid.text = payable.toStringAsFixed(2);
    }
  }

  void _onDiscPercent(double total) {
    if (_updatingDisc) return;
    _updatingDisc = true;
    final pct = double.tryParse(_discPct.text.trim()) ?? 0;
    final amt = (total * pct / 100).clamp(0, total);
    _discAmt.text = amt.toStringAsFixed(2);
    _syncPaidFromPayable(total - amt);
    _updatingDisc = false;
    setState(() {});
  }

  void _onDiscAmount(double total) {
    if (_updatingDisc) return;
    _updatingDisc = true;
    final amt = (double.tryParse(_discAmt.text.trim()) ?? 0).clamp(0, total);
    final pct = total <= 0 ? 0.0 : (amt * 100 / total);
    _discPct.text = pct.toStringAsFixed(2);
    _syncPaidFromPayable(total - amt);
    _updatingDisc = false;
    setState(() {});
  }

  Future<void> _save(List<LabTest> allTests, List<Doctor> doctors) async {
    // Patient form is not mounted on step 2 — validate from controllers only.
    final patientError = _patientValidationError(doctors: doctors);
    if (patientError != null) {
      setState(() => _step = 0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(patientError)));
      return;
    }
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one Test To Be Add to Generate Bill.')),
      );
      return;
    }

    final tests = allTests.where((t) => _selected.contains(t.id)).toList();
    final lines = [
      for (final t in tests)
        BillLine(
          test: t,
          price: (_linePrices[t.id] ?? t.price).clamp(0, t.price).toDouble(),
        ),
    ];
    final total = lines.fold<double>(0, (s, l) => s + l.price);
    final discAmt = (double.tryParse(_discAmt.text.trim()) ?? 0).clamp(0, total);
    final discPct = double.tryParse(_discPct.text.trim()) ?? 0;
    if (discPct < 0 || discAmt < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Discount cannot be negative')),
      );
      return;
    }
    final payable = (total - discAmt).clamp(0, double.infinity).toDouble();
    var paid = double.tryParse(_paid.text.trim()) ?? 0;
    if (_payMethod == 'pay_later') paid = 0;
    if (paid < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paid amount cannot be negative')),
      );
      return;
    }
    paid = paid.clamp(0, payable).toDouble();

    setState(() => _saving = true);
    try {
      final repo = LabRepository(AppScope.of(context).db);
      await repo.ensureSelfDoctor();
      final id = await repo.registerPatient(
        prefix: _prefix.text,
        firstName: _first.text,
        lastName: _last.text,
        age: int.tryParse(_age.text.trim().split('.').first),
        sex: _sex,
        phone: _phone.text,
        email: _email.text,
        address: _address.text,
        remark: _remark.text,
        doctorId: _doctorId,
        lines: lines,
        discountAmount: discAmt.toDouble(),
        discountPercent: discPct,
        payableAmount: payable,
        paidAmount: paid,
        paymentMethod: _payMethod,
      );
      if (!mounted) return;
      final action = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Bill saved (#$id)'),
          content: const Text('Choose the next step (same as web Generate Bill / Bill and Entry).'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, 'done'), child: const Text('Done')),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'queue'),
              child: const Text('Generate Bill'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, 'entry'),
              child: const Text('Bill and Entry'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      setState(_resetForm);
      final nav = widget.onNavigate;
      if (nav == null) return;
      if (action == 'queue') {
        nav(AppSection.enterVerify);
      } else if (action == 'entry') {
        nav(AppSection.enterVerify, patientId: id);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  double _lineTotal(List<LabTest> tests) {
    return tests
        .where((t) => _selected.contains(t.id))
        .fold<double>(0, (s, t) => s + (_linePrices[t.id] ?? t.price));
  }

  String get _patientSummary {
    final name = [_prefix.text, _first.text.trim(), _last.text.trim()]
        .where((e) => e.isNotEmpty)
        .join(' ');
    final bits = <String>[
      if (name.isNotEmpty) name,
      if (_age.text.trim().isNotEmpty) '${_age.text.trim()}y',
      _sex,
      if (_phone.text.trim().isNotEmpty) _phone.text.trim(),
    ];
    return bits.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    return PageScaffold(
      child: StreamBuilder<List<LabTest>>(
        stream: repo.watchTests(),
        builder: (context, testSnap) {
          return StreamBuilder<List<Doctor>>(
            stream: repo.watchDoctors(),
            builder: (context, docSnap) {
              final tests = testSnap.data ?? [];
              final doctors = docSnap.data ?? [];

              if (doctors.isNotEmpty && _doctorId == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted || _doctorId != null) return;
                  Doctor? internal;
                  for (final d in doctors) {
                    if (d.isInternal) {
                      internal = d;
                      break;
                    }
                  }
                  setState(() => _doctorId = internal?.id ?? doctors.first.id);
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StepHeader(
                    step: _step,
                    onStepTap: (i) {
                      if (i == 0) {
                        setState(() => _step = 0);
                      } else if (_validatePatient(doctors: doctors)) {
                        setState(() => _step = 1);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  if (_step == 0)
                    _PatientStep(
                      formKey: _patientFormKey,
                      autovalidate: _autovalidate,
                      prefix: _prefix,
                      first: _first,
                      last: _last,
                      age: _age,
                      phone: _phone,
                      email: _email,
                      address: _address,
                      remark: _remark,
                      sex: _sex,
                      doctorId: _doctorId,
                      doctors: doctors,
                      onSex: (v) => setState(() => _sex = v),
                      onDoctor: (v) => setState(() => _doctorId = v),
                      onContinue: () => _goBilling(doctors),
                    )
                  else
                    _BillingStep(
                      patientSummary: _patientSummary,
                      tests: tests,
                      selected: _selected,
                      linePrices: _linePrices,
                      testSearch: _testSearch,
                      discPct: _discPct,
                      discAmt: _discAmt,
                      paid: _paid,
                      payMethod: _payMethod,
                      saving: _saving,
                      onBack: () => setState(() => _step = 0),
                      onRebuild: () => setState(() {}),
                      onPayMethod: (m, payable) {
                        setState(() {
                          _payMethod = m;
                          _syncPaidFromPayable(payable);
                        });
                      },
                      onDiscPercent: _onDiscPercent,
                      onDiscAmount: _onDiscAmount,
                      onToggleTest: (test, checked) {
                        setState(() {
                          if (checked) {
                            _selected.add(test.id);
                            _linePrices[test.id] = test.price;
                          } else {
                            _selected.remove(test.id);
                            _linePrices.remove(test.id);
                          }
                        });
                        _onDiscPercent(_lineTotal(tests));
                      },
                      onLinePrice: (test, price) {
                        setState(() {
                          _linePrices[test.id] = price.clamp(0, test.price).toDouble();
                        });
                        _onDiscPercent(_lineTotal(tests));
                      },
                      onSave: () => _save(tests, doctors),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step, required this.onStepTap});

  final int step;
  final ValueChanged<int> onStepTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Expanded(
            child: _StepChip(
              index: 1,
              label: 'Patient',
              active: step == 0,
              done: step > 0,
              onTap: () => onStepTap(0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 18,
              color: AppColors.muted.withValues(alpha: 0.7),
            ),
          ),
          Expanded(
            child: _StepChip(
              index: 2,
              label: 'Tests & payment',
              active: step == 1,
              done: false,
              onTap: () => onStepTap(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({
    required this.index,
    required this.label,
    required this.active,
    required this.done,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool active;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppColors.splashAccent
        : done
            ? AppColors.success
            : AppColors.muted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.softTeal : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? AppColors.splashAccent.withValues(alpha: 0.35) : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color.withValues(alpha: 0.15),
              child: done && !active
                  ? Icon(Icons.check, size: 14, color: color)
                  : Text(
                      '$index',
                      style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12),
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: active ? AppColors.text : AppColors.muted,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientStep extends StatelessWidget {
  const _PatientStep({
    required this.formKey,
    required this.autovalidate,
    required this.prefix,
    required this.first,
    required this.last,
    required this.age,
    required this.phone,
    required this.email,
    required this.address,
    required this.remark,
    required this.sex,
    required this.doctorId,
    required this.doctors,
    required this.onSex,
    required this.onDoctor,
    required this.onContinue,
  });

  final GlobalKey<FormState> formKey;
  final bool autovalidate;
  final TextEditingController prefix;
  final TextEditingController first;
  final TextEditingController last;
  final TextEditingController age;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController address;
  final TextEditingController remark;
  final String sex;
  final int? doctorId;
  final List<Doctor> doctors;
  final ValueChanged<String> onSex;
  final ValueChanged<int?> onDoctor;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Patient details',
      subtitle: 'Step 1 · same validation as TubTrace web',
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    initialValue: prefix.text,
                    isDense: true,
                    decoration: const InputDecoration(labelText: 'Prefix'),
                    items: const [
                      DropdownMenuItem(value: 'Mr.', child: Text('Mr.')),
                      DropdownMenuItem(value: 'Ms.', child: Text('Ms.')),
                      DropdownMenuItem(value: 'Mrs.', child: Text('Mrs.')),
                    ],
                    onChanged: (v) => prefix.text = v ?? 'Mr.',
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: TextFormField(
                    controller: first,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'First name *'),
                    validator: (_) {
                      final value = first.text.trim();
                      if (value.isEmpty) return 'First name is required';
                      if (value.length < 3) return 'Minimum 3 characters';
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: TextFormField(
                    controller: last,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Last name'),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: TextFormField(
                    controller: age,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                    decoration: const InputDecoration(labelText: 'Age *'),
                    validator: (_) {
                      final value = age.text.trim();
                      if (value.isEmpty) return 'Age is required';
                      final n = double.tryParse(value);
                      if (n == null) return 'Age must be a number';
                      if (n <= 0 || n > 150) return 'Enter a valid age';
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: const InputDecoration(labelText: 'Mobile *'),
                    validator: (_) {
                      final value = phone.text.trim();
                      if (value.isEmpty) return 'Mobile is required';
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter 10 digit mobile';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (_) {
                      final value = email.text.trim();
                      if (value.isEmpty) return null;
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender *',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.muted),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: [
                          for (final g in ['Male', 'Female', 'Other'])
                            ChoiceChip(
                              label: Text(g),
                              selected: sex == g,
                              visualDensity: VisualDensity.compact,
                              onSelected: (_) => onSex(g),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 280,
                  child: DropdownButtonFormField<int?>(
                    key: ValueKey('doctor_$doctorId'),
                    initialValue: doctorId,
                    isDense: true,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Referred by *'),
                    hint: const Text('Select doctor'),
                    items: [
                      for (final d in doctors)
                        DropdownMenuItem<int?>(
                          value: d.id,
                          child: Text(
                            d.isInternal
                                ? 'Self (Lab)'
                                : '${d.name}${d.org.isEmpty ? '' : ' (${d.org})'}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: doctors.isEmpty ? null : onDoctor,
                    validator: (_) {
                      if (doctors.isEmpty) return 'Add a doctor first';
                      if (doctorId == null) return 'Referred by is required';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: address,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: remark,
                    decoration: const InputDecoration(labelText: 'Remark'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: onContinue,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Continue to billing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BillingStep extends StatelessWidget {
  const _BillingStep({
    required this.patientSummary,
    required this.tests,
    required this.selected,
    required this.linePrices,
    required this.testSearch,
    required this.discPct,
    required this.discAmt,
    required this.paid,
    required this.payMethod,
    required this.saving,
    required this.onBack,
    required this.onRebuild,
    required this.onPayMethod,
    required this.onDiscPercent,
    required this.onDiscAmount,
    required this.onToggleTest,
    required this.onLinePrice,
    required this.onSave,
  });

  final String patientSummary;
  final List<LabTest> tests;
  final Set<int> selected;
  final Map<int, double> linePrices;
  final TextEditingController testSearch;
  final TextEditingController discPct;
  final TextEditingController discAmt;
  final TextEditingController paid;
  final String payMethod;
  final bool saving;
  final VoidCallback onBack;
  final VoidCallback onRebuild;
  final void Function(String method, double payable) onPayMethod;
  final ValueChanged<double> onDiscPercent;
  final ValueChanged<double> onDiscAmount;
  final void Function(LabTest test, bool checked) onToggleTest;
  final void Function(LabTest test, double price) onLinePrice;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final q = testSearch.text.trim().toLowerCase();
    final filtered = q.isEmpty
        ? tests
        : tests
            .where((t) =>
                t.code.toLowerCase().contains(q) ||
                t.name.toLowerCase().contains(q) ||
                t.department.toLowerCase().contains(q))
            .toList();
    final selectedTests = tests.where((t) => selected.contains(t.id)).toList();
    final total = selectedTests.fold<double>(0, (s, t) => s + (linePrices[t.id] ?? t.price));
    final discAmtVal = (double.tryParse(discAmt.text.trim()) ?? 0).clamp(0, total);
    final payable = (total - discAmtVal).clamp(0, double.infinity);
    final paidVal = payMethod == 'pay_later'
        ? 0.0
        : (double.tryParse(paid.text.trim()) ?? 0).clamp(0, payable);
    final due = (payable - paidVal).clamp(0, double.infinity);

    final testsCard = SectionCard(
      title: 'Book tests',
      subtitle: patientSummary,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectedTests.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final t in selectedTests)
                  InputChip(
                    label: Text(
                      '${t.code} ₹${(linePrices[t.id] ?? t.price).toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    visualDensity: VisualDensity.compact,
                    onDeleted: () => onToggleTest(t, false),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            for (final t in selectedTests)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${t.code} — ${t.name}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: TextFormField(
                        key: ValueKey('price_${t.id}_${linePrices[t.id]}'),
                        initialValue: (linePrices[t.id] ?? t.price).toStringAsFixed(0),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Price',
                          helperText: 'Max ₹${t.price.toStringAsFixed(0)}',
                        ),
                        onChanged: (v) {
                          final raw = double.tryParse(v.trim()) ?? t.price;
                          onLinePrice(t, raw);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
          TextField(
            controller: testSearch,
            onChanged: (_) => onRebuild(),
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Search tests',
              hintText: 'Code, name or department…',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: q.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        testSearch.clear();
                        onRebuild();
                      },
                      icon: const Icon(Icons.clear, size: 18),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${selected.length} selected · showing ${filtered.length} of ${tests.length}',
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          if (tests.isEmpty)
            const Text('No tests in catalog. Add some in Tests.', style: TextStyle(color: AppColors.muted))
          else if (filtered.isEmpty)
            const Text('No tests match your search.', style: TextStyle(color: AppColors.muted))
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 420),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final t = filtered[i];
                  final checked = selected.contains(t.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: checked
                          ? AppColors.splashAccent.withValues(alpha: 0.06)
                          : AppColors.pageBg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: CheckboxListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      value: checked,
                      title: Text(
                        '${t.code} — ${t.name}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      subtitle: Text(
                        '₹ ${t.price.toStringAsFixed(0)} · ${t.department}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onChanged: (v) => onToggleTest(t, v == true),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );

    final billing = SectionCard(
      title: 'Billing summary',
      subtitle: 'Cash / UPI / Due · Generate Bill after save',
      accent: AppColors.blue,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BillRow(label: 'Tests selected', value: '${selectedTests.length}'),
          _BillRow(label: 'Total', value: '₹ ${total.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          TextField(
            controller: discPct,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onDiscPercent(total),
            decoration: const InputDecoration(labelText: 'Discount %', isDense: true),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: discAmt,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onDiscAmount(total),
            decoration: const InputDecoration(labelText: 'Discount amount', isDense: true),
          ),
          const SizedBox(height: 8),
          _BillRow(label: 'Payable', value: '₹ ${payable.toStringAsFixed(2)}'),
          const SizedBox(height: 10),
          const Text('Payment method', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.muted)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final m in const [
                ('cash', 'Cash'),
                ('upi', 'UPI'),
                ('pay_later', 'Due'),
              ])
                ChoiceChip(
                  label: Text(m.$2),
                  selected: payMethod == m.$1,
                  visualDensity: VisualDensity.compact,
                  onSelected: (_) => onPayMethod(m.$1, payable.toDouble()),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: paid,
            enabled: payMethod != 'pay_later',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onRebuild(),
            decoration: InputDecoration(
              isDense: true,
              labelText: payMethod == 'pay_later' ? 'Paid amount (due)' : 'Paid amount',
            ),
          ),
          const SizedBox(height: 8),
          _BillRow(label: 'Due', value: '₹ ${due.toStringAsFixed(2)}'),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: const Text('Back to patient'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: saving ? null : onSave,
            icon: const Icon(Icons.receipt_long_outlined),
            label: Text(saving ? 'Saving…' : 'Generate Bill'),
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 980) {
          return Column(
            children: [
              testsCard,
              const SizedBox(height: 12),
              billing,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: testsCard),
            const SizedBox(width: 12),
            SizedBox(width: 320, child: billing),
          ],
        );
      },
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 13))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        ],
      ),
    );
  }
}
