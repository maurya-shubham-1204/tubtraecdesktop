import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/services/formula_evaluator.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/ui_bits.dart';

class EnterVerifyPage extends StatefulWidget {
  const EnterVerifyPage({
    super.key,
    this.initialPatientId,
    this.onNavigate,
  });

  final int? initialPatientId;
  final ShellNavigate? onNavigate;

  @override
  State<EnterVerifyPage> createState() => _EnterVerifyPageState();
}

class _EnterVerifyPageState extends State<EnterVerifyPage> {
  Patient? _selected;
  List<EntryParameterRow> _rows = [];
  final _controllers = <int, TextEditingController>{};
  final _formulaDisplay = <int, String>{};
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeOpenInitial());
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _maybeOpenInitial() async {
    final id = widget.initialPatientId;
    if (id == null) return;
    final repo = LabRepository(AppScope.of(context).db);
    final p = await repo.getPatient(id);
    if (p == null || !mounted) return;
    await _select(p);
  }

  Map<int, String> _currentValues() {
    final values = <int, String>{};
    for (final row in _rows) {
      final id = row.parameter.id;
      final type = row.parameter.valueType.toLowerCase();
      if (type == 'formula') {
        values[id] = _formulaDisplay[id] ?? '';
      } else {
        values[id] = _controllers[id]?.text.trim() ?? '';
      }
    }
    return values;
  }

  void _recalcFormulas() {
    final values = _currentValues();
    // Clear formula slots before apply so stale values don't fake deps.
    for (final row in _rows) {
      if (row.parameter.valueType.toLowerCase() == 'formula') {
        values[row.parameter.id] = '';
      }
    }
    FormulaEvaluator.applyFormulas(
      _rows.map((r) => (
            id: r.parameter.id,
            valueType: r.parameter.valueType,
            formula: r.parameter.formula,
          )),
      values,
    );
    for (final row in _rows) {
      if (row.parameter.valueType.toLowerCase() != 'formula') continue;
      final id = row.parameter.id;
      final shown = FormulaEvaluator.shouldShowFormula(row.parameter.formula, values);
      _formulaDisplay[id] = shown ? (values[id] ?? '') : '';
    }
  }

  Future<void> _select(Patient p) async {
    setState(() => _loading = true);
    final repo = LabRepository(AppScope.of(context).db);
    final rows = await repo.entryRowsForPatient(p.id);
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    _formulaDisplay.clear();
    for (final row in rows) {
      final type = row.parameter.valueType.toLowerCase();
      if (type == 'formula') {
        _formulaDisplay[row.parameter.id] = row.existingValue;
      } else {
        _controllers[row.parameter.id] = TextEditingController(text: row.existingValue);
      }
    }
    if (!mounted) return;
    setState(() {
      _selected = p;
      _rows = rows;
      _loading = false;
    });
    setState(_recalcFormulas);
  }

  Future<void> _save({required bool verify}) async {
    if (_selected == null) return;
    final repo = LabRepository(AppScope.of(context).db);
    final values = _currentValues();
    final error = repo.prepareReadingsForSave(_rows, values);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    // Sync formula controllers map for save.
    for (final row in _rows) {
      if (row.parameter.valueType.toLowerCase() == 'formula') {
        values[row.parameter.id] = _formulaDisplay[row.parameter.id] ?? values[row.parameter.id] ?? '';
      }
    }
    await repo.saveReadings(
      patientId: _selected!.id,
      rows: _rows,
      valuesByParameterId: values,
      verify: verify,
    );
    if (!mounted) return;
    if (verify) {
      final id = _selected!.id;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved and verified')),
      );
      setState(() {
        _selected = null;
        _rows = [];
      });
      widget.onNavigate?.call(AppSection.report, patientId: id, openReport: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Readings saved')));
      final refreshed = await repo.getPatient(_selected!.id);
      if (refreshed != null && mounted) await _select(refreshed);
    }
  }

  List<Widget> _buildRowWidgets() {
    final widgets = <Widget>[];
    for (var i = 0; i < _rows.length; i++) {
      final row = _rows[i];
      final prev = i > 0 ? _rows[i - 1] : null;
      if (prev == null || row.testId != prev.testId) {
        widgets.add(
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 12, bottom: 8),
            child: Text(
              '${row.testCode} — ${row.testName}',
              style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.splashAccent),
            ),
          ),
        );
      }
      final section = row.parameter.sectionTitle?.trim();
      final prevSection = prev?.parameter.sectionTitle?.trim();
      if (section != null &&
          section.isNotEmpty &&
          (prev == null || row.testId != prev.testId || section != prevSection)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Text(
              section,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.muted),
            ),
          ),
        );
      }

      final type = row.parameter.valueType.toLowerCase();
      if (type == 'formula') {
        final shown = (_formulaDisplay[row.parameter.id] ?? '').isNotEmpty;
        if (!shown) {
          // Hidden until inputs ready (web parity).
        } else {
          widgets.add(_formulaField(row));
          widgets.add(const SizedBox(height: 10));
        }
      } else {
        widgets.add(_inputFor(row));
        widgets.add(const SizedBox(height: 10));
      }

      // Group-sum footer when section ends.
      final next = i + 1 < _rows.length ? _rows[i + 1] : null;
      final sectionEnds = section != null &&
          section.isNotEmpty &&
          (next == null ||
              next.testId != row.testId ||
              next.parameter.sectionTitle?.trim() != section);
      if (sectionEnds) {
        double? target;
        for (final r in _rows) {
          if (r.patientTestId != row.patientTestId) continue;
          if (r.parameter.sectionTitle?.trim() != section) continue;
          if (r.parameter.groupSumEquals != null) {
            target = r.parameter.groupSumEquals;
            break;
          }
        }
        if (target != null) {
          widgets.add(_groupSumFooter(row.patientTestId, section, target));
          widgets.add(const SizedBox(height: 10));
        }
      }
    }
    return widgets;
  }

  Widget _groupSumFooter(int patientTestId, String section, double target) {
    final values = _currentValues();
    var sum = 0.0;
    var complete = true;
    for (final row in _rows) {
      if (row.patientTestId != patientTestId) continue;
      if (row.parameter.sectionTitle?.trim() != section) continue;
      if (row.parameter.groupSumEquals == null) continue;
      if (row.parameter.valueType.toLowerCase() == 'formula') continue;
      final raw = values[row.parameter.id] ?? '';
      if (!FormulaEvaluator.isNumericReading(raw)) {
        complete = false;
        break;
      }
      sum += double.parse(raw.trim());
    }
    final ok = complete && (sum - target).abs() <= 0.01;
    final label = complete
        ? 'Sum: ${sum.toStringAsFixed(2)} / ${target.toStringAsFixed(2)}'
        : 'Sum: — / ${target.toStringAsFixed(2)}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ok ? AppColors.success.withValues(alpha: 0.08) : AppColors.amber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ok ? AppColors.success.withValues(alpha: 0.35) : AppColors.amber),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: ok ? AppColors.success : AppColors.amber,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _formulaField(EntryParameterRow row) {
    final p = row.parameter;
    final text = _formulaDisplay[p.id] ?? '';
    return InputDecorator(
      decoration: InputDecoration(
        labelText: '${p.title} (formula)',
        suffixText: p.unit.isEmpty ? null : p.unit,
        helperText: p.formula.isEmpty ? null : p.formula,
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
    );
  }

  Widget _inputFor(EntryParameterRow row) {
    final p = row.parameter;
    final type = p.valueType.toLowerCase();
    final c = _controllers[p.id]!;
    void onChanged() {
      setState(_recalcFormulas);
    }

    if (type == 'negative_positive') {
      const opts = ['Positive', 'Negative'];
      final current = c.text.isEmpty ? null : c.text;
      return DropdownButtonFormField<String>(
        key: ValueKey('np_${p.id}_${c.text}'),
        initialValue: opts.contains(current) ? current : null,
        decoration: InputDecoration(labelText: p.title, helperText: p.unit.isEmpty ? null : p.unit),
        items: [for (final o in opts) DropdownMenuItem(value: o, child: Text(o))],
        onChanged: (v) {
          c.text = v ?? '';
          onChanged();
        },
      );
    }
    if (type == 'qualitative' || type == 'select') {
      const opts = ['Positive', 'Negative', 'Reactive', 'Non-Reactive'];
      final current = c.text.isEmpty ? null : c.text;
      return DropdownButtonFormField<String>(
        key: ValueKey('q_${p.id}_${c.text}'),
        initialValue: opts.contains(current) ? current : null,
        decoration: InputDecoration(labelText: p.title, helperText: p.unit.isEmpty ? null : p.unit),
        items: [for (final o in opts) DropdownMenuItem(value: o, child: Text(o))],
        onChanged: (v) {
          c.text = v ?? '';
          onChanged();
        },
      );
    }
    return TextField(
      controller: c,
      keyboardType: type == 'float' || type == 'number'
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      onChanged: (_) => onChanged(),
      decoration: InputDecoration(
        labelText: p.title,
        suffixText: p.unit.isEmpty ? null : p.unit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    final fmt = DateFormat('dd MMM');

    return PageScaffold(
      child: StreamBuilder<List<Patient>>(
        stream: repo.watchPendingPatients(),
        builder: (context, snap) {
          final pending = snap.data ?? [];
          final list = Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                  child: Text('Pending cases', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                ),
                const Divider(height: 1),
                if (pending.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('All clear', style: TextStyle(color: AppColors.muted)),
                  )
                else
                  ...pending.map((c) {
                    final active = _selected?.id == c.id;
                    return InkWell(
                      onTap: () => _select(c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: active ? AppColors.splashAccent.withValues(alpha: 0.08) : null,
                          border: Border(
                            left: BorderSide(
                              color: active ? AppColors.splashAccent : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(patientDisplayName(c), style: const TextStyle(fontWeight: FontWeight.w700)),
                                  Text(
                                    'P-${c.id} · ${patientListStatus(c)}',
                                    style: const TextStyle(color: AppColors.muted, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Text(fmt.format(c.createdAt), style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }),
              ],
            ),
          );

          final editor = SectionCard(
            title: _selected == null ? 'Readings' : patientDisplayName(_selected!),
            trailing: _selected == null
                ? null
                : StatusChip(label: patientListStatus(_selected!), color: AppColors.blue),
            child: _selected == null
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: Text(
                        'Select a pending case to enter readings',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ),
                  )
                : _loading
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('P-${_selected!.id}', style: const TextStyle(color: AppColors.muted)),
                          const SizedBox(height: 12),
                          if (_rows.isEmpty)
                            const Text(
                              'No parameters on booked tests. Add parameters in Tests.',
                              style: TextStyle(color: AppColors.muted),
                            )
                          else
                            ..._buildRowWidgets(),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              FilledButton.icon(
                                onPressed: () => _save(verify: false),
                                icon: const Icon(Icons.save_outlined),
                                label: const Text('Save'),
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () => _save(verify: true),
                                icon: const Icon(Icons.verified_outlined),
                                label: const Text('Save and Verify'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => widget.onNavigate?.call(
                                  AppSection.report,
                                  patientId: _selected!.id,
                                  openReport: true,
                                ),
                                icon: const Icon(Icons.description_outlined),
                                label: const Text('Report'),
                              ),
                            ],
                          ),
                        ],
                      ),
          );

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 980) {
                return Column(children: [list, const SizedBox(height: 14), editor]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 340, child: list),
                  const SizedBox(width: 14),
                  Expanded(child: editor),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
