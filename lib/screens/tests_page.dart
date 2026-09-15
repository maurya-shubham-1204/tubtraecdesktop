import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  Future<void> _addOrEdit(BuildContext context, {LabTest? existing}) async {
    final code = TextEditingController(text: existing?.code ?? '');
    final name = TextEditingController(text: existing?.name ?? '');
    final dept = TextEditingController(text: existing?.department ?? 'General');
    final price = TextEditingController(text: existing?.price.toStringAsFixed(0) ?? '0');
    final maxDisc = TextEditingController(text: existing?.maxDisc.toStringAsFixed(0) ?? '0');
    final formKey = GlobalKey<FormState>();

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'Add test' : 'Edit test'),
        content: Form(
          key: formKey,
          child: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: code,
                  decoration: const InputDecoration(labelText: 'Code'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(controller: dept, decoration: const InputDecoration(labelText: 'Department')),
                const SizedBox(height: 10),
                TextFormField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: maxDisc,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Max discount'),
                ),
              ],
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
      await repo.addTest(
        code: code.text,
        name: name.text,
        department: dept.text,
        price: double.tryParse(price.text) ?? 0,
        maxDisc: double.tryParse(maxDisc.text) ?? 0,
      );
    } else {
      await repo.updateTest(
        existing.copyWith(
          code: code.text.trim().toUpperCase(),
          name: name.text.trim(),
          department: dept.text.trim(),
          price: double.tryParse(price.text) ?? 0,
          maxDisc: double.tryParse(maxDisc.text) ?? 0,
        ),
      );
    }
  }

  Future<void> _editParameters(BuildContext context, LabTest test) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _ParameterEditorDialog(test: test),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    return PageScaffold(
      child: StreamBuilder<List<LabTest>>(
        stream: repo.watchTests(),
        builder: (context, snap) {
          final tests = snap.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: () => _addOrEdit(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add test'),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: tests.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: Text('No tests yet', style: TextStyle(color: AppColors.muted))),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: MediaQuery.sizeOf(context).width - 280),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Code')),
                              DataColumn(label: Text('Test')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Max disc')),
                              DataColumn(label: Text('Params')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: [
                              for (final t in tests)
                                DataRow(
                                  cells: [
                                    DataCell(Text(t.code, style: const TextStyle(fontWeight: FontWeight.w700))),
                                    DataCell(Text(t.name)),
                                    DataCell(Text(t.department)),
                                    DataCell(Text('₹ ${t.price.toStringAsFixed(0)}')),
                                    DataCell(Text('₹ ${t.maxDisc.toStringAsFixed(0)}')),
                                    DataCell(Text('${t.paramCount}')),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () => _addOrEdit(context, existing: t),
                                            child: const Text('Edit'),
                                          ),
                                          const SizedBox(width: 6),
                                          OutlinedButton(
                                            onPressed: () => _editParameters(context, t),
                                            child: const Text('Parameters'),
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

class _ParameterEditorDialog extends StatefulWidget {
  const _ParameterEditorDialog({required this.test});
  final LabTest test;

  @override
  State<_ParameterEditorDialog> createState() => _ParameterEditorDialogState();
}

class _ParameterEditorDialogState extends State<_ParameterEditorDialog> {
  Future<void> _addOrEdit({TestParameter? existing}) async {
    final title = TextEditingController(text: existing?.title ?? '');
    final unit = TextEditingController(text: existing?.unit ?? '');
    final order = TextEditingController(text: '${existing?.sortOrder ?? 0}');
    final formula = TextEditingController(text: existing?.formula ?? '');
    final section = TextEditingController(text: existing?.sectionTitle ?? '');
    final groupSum = TextEditingController(
      text: existing?.groupSumEquals == null ? '' : existing!.groupSumEquals!.toStringAsFixed(2),
    );
    var valueType = existing?.valueType ?? 'float';
    final formKey = GlobalKey<FormState>();

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text(existing == null ? 'Add parameter' : 'Edit parameter'),
          content: Form(
            key: formKey,
            child: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(controller: unit, decoration: const InputDecoration(labelText: 'Unit')),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: order,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(labelText: 'Sort order'),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: valueType,
                      decoration: const InputDecoration(labelText: 'Value type'),
                      items: const [
                        DropdownMenuItem(value: 'float', child: Text('float')),
                        DropdownMenuItem(value: 'text', child: Text('text')),
                        DropdownMenuItem(value: 'qualitative', child: Text('qualitative')),
                        DropdownMenuItem(value: 'negative_positive', child: Text('negative_positive')),
                        DropdownMenuItem(value: 'formula', child: Text('formula')),
                      ],
                      onChanged: (v) => setLocal(() => valueType = v ?? 'float'),
                    ),
                    if (valueType == 'formula') ...[
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: formula,
                        decoration: const InputDecoration(
                          labelText: 'Formula',
                          hintText: 'e.g. (#12)/(#13)*100',
                        ),
                        validator: (v) {
                          if (valueType != 'formula') return null;
                          if (v == null || v.trim().isEmpty) return 'Formula required';
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: section,
                      decoration: const InputDecoration(labelText: 'Section title'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: groupSum,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Group sum equals',
                        hintText: 'Optional target total for section',
                      ),
                    ),
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
      ),
    );
    if (ok != true || !mounted) return;
    final repo = LabRepository(AppScope.of(context).db);
    final groupVal = groupSum.text.trim().isEmpty ? null : double.tryParse(groupSum.text.trim());
    final sectionVal = section.text.trim().isEmpty ? null : section.text.trim();
    if (existing == null) {
      await repo.addParameter(
        testId: widget.test.id,
        title: title.text,
        unit: unit.text,
        valueType: valueType,
        formula: valueType == 'formula' ? formula.text : '',
        groupSumEquals: groupVal,
        sectionTitle: sectionVal,
        sortOrder: int.tryParse(order.text) ?? 0,
      );
    } else {
      await repo.updateParameter(
        existing.copyWith(
          title: title.text.trim(),
          unit: unit.text.trim(),
          valueType: valueType,
          formula: valueType == 'formula' ? formula.text.trim() : '',
          groupSumEquals: Value(groupVal),
          sectionTitle: Value(sectionVal),
          sortOrder: int.tryParse(order.text) ?? 0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    return AlertDialog(
      title: Text('Parameters · ${widget.test.code}'),
      content: SizedBox(
        width: 520,
        height: 360,
        child: StreamBuilder<List<TestParameter>>(
          stream: repo.watchParametersForTest(widget.test.id),
          builder: (context, snap) {
            final rows = snap.data ?? [];
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.tonalIcon(
                    onPressed: () => _addOrEdit(),
                    icon: const Icon(Icons.add),
                    label: const Text('Add parameter'),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: rows.isEmpty
                      ? const Center(child: Text('No parameters', style: TextStyle(color: AppColors.muted)))
                      : ListView.separated(
                          itemCount: rows.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final p = rows[i];
                            return ListTile(
                              dense: true,
                              title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                              subtitle: Text(
                                [
                                  p.valueType,
                                  if (p.valueType == 'formula' && p.formula.isNotEmpty) p.formula,
                                  p.unit.isEmpty ? 'no unit' : p.unit,
                                  'order ${p.sortOrder}',
                                  if (p.sectionTitle != null && p.sectionTitle!.isNotEmpty) '§ ${p.sectionTitle}',
                                ].join(' · '),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => _addOrEdit(existing: p),
                                    icon: const Icon(Icons.edit_outlined, size: 18),
                                  ),
                                  IconButton(
                                    onPressed: () => repo.deleteParameter(p.id),
                                    icon: const Icon(Icons.delete_outline, size: 18),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }
}
