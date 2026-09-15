import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  Future<void> _addOrEdit(BuildContext context, {Doctor? existing}) async {
    if (existing?.isInternal == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Self (Lab) is protected — name/commission fixed for billing.')),
      );
    }
    final name = TextEditingController(text: existing?.name ?? '');
    final phone = TextEditingController(text: existing?.phone ?? '');
    final org = TextEditingController(text: existing?.org ?? '');
    final email = TextEditingController(text: existing?.email ?? '');
    final address = TextEditingController(text: existing?.address ?? '');
    final commission = TextEditingController(
      text: existing?.commissionPercent.toStringAsFixed(0) ?? '0',
    );
    final formKey = GlobalKey<FormState>();
    final isInternal = existing?.isInternal == true;

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'Add doctor' : 'Edit doctor'),
        content: Form(
          key: formKey,
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                    enabled: !isInternal,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone')),
                  const SizedBox(height: 10),
                  TextFormField(controller: org, decoration: const InputDecoration(labelText: 'Organization')),
                  const SizedBox(height: 10),
                  TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 10),
                  TextFormField(controller: address, decoration: const InputDecoration(labelText: 'Address')),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: commission,
                    enabled: !isInternal,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: 'Commission %'),
                  ),
                  if (existing != null) ...[
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Wallet: ₹ ${existing.wallet.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final repo = LabRepository(AppScope.of(context).db);
    if (existing == null) {
      await repo.addDoctor(
        name: name.text,
        phone: phone.text,
        org: org.text,
        email: email.text,
        address: address.text,
        commission: double.tryParse(commission.text) ?? 0,
      );
    } else if (!isInternal) {
      await repo.updateDoctor(
        existing.copyWith(
          name: name.text.trim(),
          phone: phone.text.trim(),
          org: org.text.trim(),
          email: email.text.trim(),
          address: address.text.trim(),
          commissionPercent: double.tryParse(commission.text) ?? 0,
        ),
      );
    } else {
      await repo.updateDoctor(
        existing.copyWith(
          phone: phone.text.trim(),
          org: org.text.trim(),
          email: email.text.trim(),
          address: address.text.trim(),
        ),
      );
    }
  }

  Future<void> _delete(BuildContext context, Doctor d) async {
    if (d.isInternal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot delete Self (Lab) doctor')),
      );
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete doctor?'),
        content: Text('Remove ${d.name} from the list?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      await LabRepository(AppScope.of(context).db).deleteDoctor(d.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    return PageScaffold(
      child: StreamBuilder<List<Doctor>>(
        stream: repo.watchDoctors(),
        builder: (context, snap) {
          final doctors = snap.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: () => _addOrEdit(context),
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Add doctor'),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: doctors.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: Text('No doctors yet', style: TextStyle(color: AppColors.muted))),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: MediaQuery.sizeOf(context).width - 280),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Doctor')),
                              DataColumn(label: Text('Org')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Commission')),
                              DataColumn(label: Text('Wallet')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: [
                              for (final d in doctors)
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        d.isInternal ? 'Self (Lab)' : d.name,
                                        style: const TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    DataCell(Text(d.org.isEmpty ? '—' : d.org)),
                                    DataCell(Text(d.phone.isEmpty ? '—' : d.phone)),
                                    DataCell(Text(d.email.isEmpty ? '—' : d.email)),
                                    DataCell(Text('${d.commissionPercent.toStringAsFixed(0)}%')),
                                    DataCell(Text('₹ ${d.wallet.toStringAsFixed(0)}')),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () => _addOrEdit(context, existing: d),
                                            child: const Text('Edit'),
                                          ),
                                          if (!d.isInternal) ...[
                                            const SizedBox(width: 6),
                                            TextButton(
                                              onPressed: () => _delete(context, d),
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
