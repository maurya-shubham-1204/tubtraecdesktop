import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/ui_bits.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key, this.onNavigate});

  final ShellNavigate? onNavigate;

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  String _query = '';
  String _status = 'All'; // All | Pending | Completed
  DateTime? _from;
  DateTime? _to;

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'Due':
        return AppColors.red;
      default:
        return AppColors.blue;
    }
  }

  Future<void> _pickFrom() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _from ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (d != null) setState(() => _from = d);
  }

  Future<void> _pickTo() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _to ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (d != null) setState(() => _to = d);
  }

  bool _inRange(Patient p) {
    if (_from != null) {
      final start = DateTime(_from!.year, _from!.month, _from!.day);
      if (p.createdAt.isBefore(start)) return false;
    }
    if (_to != null) {
      final end = DateTime(_to!.year, _to!.month, _to!.day, 23, 59, 59);
      if (p.createdAt.isAfter(end)) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    final fmt = DateFormat('dd MMM yyyy');
    final short = DateFormat('dd MMM');

    return PageScaffold(
      child: StreamBuilder<List<Patient>>(
        stream: repo.watchBilledPatients(),
        builder: (context, snap) {
          final all = snap.data ?? [];
          final filtered = all.where((p) {
            final name = patientDisplayName(p).toLowerCase();
            final q = _query.toLowerCase();
            final matchQ = q.isEmpty ||
                name.contains(q) ||
                p.phone.contains(q) ||
                'p-${p.id}'.contains(q) ||
                '${p.id}'.contains(q);
            final listStatus = patientListStatus(p);
            final matchS = _status == 'All' ||
                (_status == 'Pending' && listStatus != 'Completed') ||
                (_status == 'Completed' && listStatus == 'Completed');
            return matchQ && matchS && _inRange(p);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: 280,
                        child: TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search, size: 20),
                            hintText: 'Search name / mobile / ID',
                          ),
                          onChanged: (v) => setState(() => _query = v),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: DropdownButtonFormField<String>(
                          initialValue: _status,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: const [
                            DropdownMenuItem(value: 'All', child: Text('All')),
                            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                            DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                          ],
                          onChanged: (v) => setState(() => _status = v ?? 'All'),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: _pickFrom,
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: Text(_from == null ? 'From date' : short.format(_from!)),
                      ),
                      OutlinedButton.icon(
                        onPressed: _pickTo,
                        icon: const Icon(Icons.event, size: 16),
                        label: Text(_to == null ? 'To date' : short.format(_to!)),
                      ),
                      if (_from != null || _to != null)
                        TextButton(
                          onPressed: () => setState(() {
                            _from = null;
                            _to = null;
                          }),
                          child: const Text('Clear dates'),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: filtered.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'No billed patients. Use New Billing.',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: MediaQuery.sizeOf(context).width - 280),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Patient')),
                              DataColumn(label: Text('Age / Sex')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Paid')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: [
                              for (final p in filtered)
                                DataRow(
                                  cells: [
                                    DataCell(Text('P-${p.id}', style: const TextStyle(fontWeight: FontWeight.w600))),
                                    DataCell(Text(patientDisplayName(p))),
                                    DataCell(Text('${p.age ?? '—'} / ${p.sex.isEmpty ? '—' : p.sex[0]}')),
                                    DataCell(Text(fmt.format(p.createdAt))),
                                    DataCell(Text('₹ ${p.payableAmount.toStringAsFixed(0)}')),
                                    DataCell(Text('₹ ${p.paidAmount.toStringAsFixed(0)}')),
                                    DataCell(
                                      StatusChip(
                                        label: patientListStatus(p),
                                        color: _statusColor(patientListStatus(p)),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () => widget.onNavigate?.call(
                                              AppSection.enterVerify,
                                              patientId: p.id,
                                            ),
                                            child: const Text('Enter'),
                                          ),
                                          TextButton(
                                            onPressed: () => widget.onNavigate?.call(
                                              AppSection.report,
                                              patientId: p.id,
                                              openReport: true,
                                            ),
                                            child: const Text('View'),
                                          ),
                                          TextButton(
                                            onPressed: () => widget.onNavigate?.call(
                                              AppSection.report,
                                              patientId: p.id,
                                              openReport: true,
                                              autoPrint: true,
                                            ),
                                            child: const Text('Print'),
                                          ),
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
