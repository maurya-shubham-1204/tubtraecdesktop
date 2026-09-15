import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/ui_bits.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this);
  DateTime _from = DateTime.now().subtract(const Duration(days: 30));
  DateTime _to = DateTime.now();
  AnalyticsSlice? _slice;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    final repo = LabRepository(AppScope.of(context).db);
    final slice = await repo.analyticsForRange(_from, _to);
    if (!mounted) return;
    setState(() {
      _slice = slice;
      _loading = false;
    });
  }

  Future<void> _pickFrom() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _from,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      setState(() => _from = d);
      await _reload();
    }
  }

  Future<void> _pickTo() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _to,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (d != null) {
      setState(() => _to = d);
      await _reload();
    }
  }

  Future<void> _exportCsv() async {
    final slice = _slice;
    if (slice == null) return;
    final csv = LabRepository(AppScope.of(context).db).analyticsCsv(slice);
    final path = await FilePicker.saveFile(
      dialogTitle: 'Export analytics CSV',
      fileName: 'tubtrace_analytics.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (path == null) return;
    await File(path).writeAsString(csv);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Exported $path')));
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM yyyy');
    final s = _slice;

    return PageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: _pickFrom,
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: Text('From ${fmt.format(_from)}'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _pickTo,
                    icon: const Icon(Icons.event, size: 16),
                    label: Text('To ${fmt.format(_to)}'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh'),
                  ),
                  FilledButton.icon(
                    onPressed: s == null ? null : _exportCsv,
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('CSV export'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          TabBar(
            controller: _tabs,
            labelColor: AppColors.splashAccent,
            tabs: const [
              Tab(text: 'Collections'),
              Tab(text: 'Volume'),
              Tab(text: 'Commissions'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabs,
                    children: [
                      _CollectionsTab(slice: s),
                      _VolumeTab(slice: s),
                      _CommissionsTab(slice: s),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _CollectionsTab extends StatelessWidget {
  const _CollectionsTab({required this.slice});
  final AnalyticsSlice? slice;

  @override
  Widget build(BuildContext context) {
    final s = slice;
    final values = [s?.collection ?? 0, s?.due ?? 0];
    final maxV = values.fold<double>(0, (a, b) => a > b ? a : b);
    return ListView(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 900 ? 3 : 1;
            final metrics = [
              ('Collection', '₹ ${(s?.collection ?? 0).toStringAsFixed(0)}'),
              ('Due', '₹ ${(s?.due ?? 0).toStringAsFixed(0)}'),
              ('Patients', '${s?.patientCount ?? 0}'),
            ];
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.4,
              children: [
                for (final m in metrics)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(m.$1, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                          const SizedBox(height: 6),
                          Text(m.$2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        SectionCard(
          title: 'Collections vs due',
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: SizedBox(
            height: 240,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (maxV / 1000) + 5,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => const FlLine(color: AppColors.border, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        const labels = ['Collection', 'Due'];
                        final i = value.toInt();
                        if (i < 0 || i > 1) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(labels[i], style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: values[0] / 1000, color: AppColors.success, width: 34),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: values[1] / 1000, color: AppColors.red, width: 34),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VolumeTab extends StatelessWidget {
  const _VolumeTab({required this.slice});
  final AnalyticsSlice? slice;

  @override
  Widget build(BuildContext context) {
    final volume = slice?.volumeByTest ?? [];
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Tests booked in range: ${slice?.testCount ?? 0}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: volume.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text('No volume in this range', style: TextStyle(color: AppColors.muted)),
                )
              : DataTable(
                  columns: const [
                    DataColumn(label: Text('Test')),
                    DataColumn(label: Text('Count')),
                  ],
                  rows: [
                    for (final e in volume)
                      DataRow(cells: [
                        DataCell(Text(e.key)),
                        DataCell(Text('${e.value}')),
                      ]),
                  ],
                ),
        ),
      ],
    );
  }
}

class _CommissionsTab extends StatelessWidget {
  const _CommissionsTab({required this.slice});
  final AnalyticsSlice? slice;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Doctor wallets (commission stock)', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(
                  '₹ ${(slice?.commissionTotal ?? 0).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Updated when bills are saved for non-internal referring doctors.',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
