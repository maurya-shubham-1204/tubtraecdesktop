import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.onNavigate});

  final ShellNavigate onNavigate;

  @override
  Widget build(BuildContext context) {
    final repo = LabRepository(AppScope.of(context).db);
    return FutureBuilder<DashboardStats>(
      future: repo.dashboardStats(),
      builder: (context, snap) {
        final stats = snap.data;
        return StreamBuilder<List<Patient>>(
          stream: repo.watchBilledPatients(),
          builder: (context, patientsSnap) {
            final patients = patientsSnap.data ?? [];
            return FutureBuilder<List<Object?>>(
              key: ValueKey(patients.length),
              future: Future.wait([
                repo.dashboardStats(),
                repo.topTests(),
              ]),
              builder: (context, multi) {
                final s = (multi.data?[0] as DashboardStats?) ?? stats;
                final top = (multi.data?[1] as List<MapEntry<String, int>>?) ?? [];
                final recent = patients.take(6).toList();
                final pending = patients.where((p) => p.status != 'Verified').take(6).toList();
                final fmt = DateFormat('dd MMM');

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton(
                            onPressed: () => onNavigate(AppSection.registration),
                            child: const Text('+ New billing'),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: AppColors.success),
                            onPressed: () => onNavigate(AppSection.enterVerify),
                            child: Text(
                              'Enter & verify${s != null && s.pendingReports > 0 ? ' (${s.pendingReports})' : ''}',
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => onNavigate(AppSection.patients),
                            child: const Text('Patients'),
                          ),
                          OutlinedButton(
                            onPressed: () => onNavigate(AppSection.doctors),
                            child: const Text('Doctors'),
                          ),
                          OutlinedButton(
                            onPressed: () => onNavigate(AppSection.analytics),
                            child: const Text('Analytics'),
                          ),
                          OutlinedButton(
                            onPressed: () => onNavigate(AppSection.tests),
                            child: const Text('Tests'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _StatsGrid(stats: s),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, c) {
                          final stacked = c.maxWidth < 900;
                          final left = _ListCard(
                            title: 'Top tests (30 days)',
                            child: top.isEmpty
                                ? const Text('No bookings yet', style: TextStyle(color: AppColors.muted))
                                : Column(
                                    children: [
                                      for (final e in top)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(e.key)),
                                              Text('${e.value}', style: const TextStyle(fontWeight: FontWeight.w700)),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                          );
                          final mid = _ListCard(
                            title: 'Recent patients',
                            child: recent.isEmpty
                                ? const Text('No patients', style: TextStyle(color: AppColors.muted))
                                : Column(
                                    children: [
                                      for (final p in recent)
                                        InkWell(
                                          onTap: () => onNavigate(
                                            AppSection.enterVerify,
                                            patientId: p.id,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(patientDisplayName(p))),
                                                Text(
                                                  fmt.format(p.createdAt),
                                                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          );
                          final right = _ListCard(
                            title: 'Pending reports',
                            child: pending.isEmpty
                                ? const Text('All clear', style: TextStyle(color: AppColors.muted))
                                : Column(
                                    children: [
                                      for (final p in pending)
                                        InkWell(
                                          onTap: () => onNavigate(
                                            AppSection.enterVerify,
                                            patientId: p.id,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 6),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(patientDisplayName(p))),
                                                Text(
                                                  fmt.format(p.createdAt),
                                                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          );
                          if (stacked) {
                            return Column(children: [
                              left,
                              const SizedBox(height: 12),
                              mid,
                              const SizedBox(height: 12),
                              right,
                            ]);
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: left),
                              const SizedBox(width: 12),
                              Expanded(child: mid),
                              const SizedBox(width: 12),
                              Expanded(child: right),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 260,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Collection snapshot', style: TextStyle(fontWeight: FontWeight.w700)),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: ((s?.todayCollection ?? 1) / 1000).clamp(5, 100).toDouble() + 5,
                                      gridData: const FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                      titlesData: FlTitlesData(
                                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (v, _) {
                                              const labels = ['Today', 'Total', 'Due'];
                                              final i = v.toInt();
                                              if (i < 0 || i > 2) return const SizedBox.shrink();
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 6),
                                                child: Text(
                                                  labels[i],
                                                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      barGroups: [
                                        BarChartGroupData(x: 0, barRods: [
                                          BarChartRodData(
                                            toY: (s?.todayCollection ?? 0) / 1000,
                                            color: AppColors.success,
                                            width: 28,
                                          ),
                                        ]),
                                        BarChartGroupData(x: 1, barRods: [
                                          BarChartRodData(
                                            toY: (s?.totalCollection ?? 0) / 1000,
                                            color: AppColors.splashAccent,
                                            width: 28,
                                          ),
                                        ]),
                                        BarChartGroupData(x: 2, barRods: [
                                          BarChartRodData(
                                            toY: (s?.totalDue ?? 0) / 1000,
                                            color: AppColors.red,
                                            width: 28,
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _StatItem {
  const _StatItem(this.label, this.today, this.total, this.showToday, this.color);
  final String label;
  final String today;
  final String total;
  final bool showToday;
  final Color color;
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});
  final DashboardStats? stats;

  @override
  Widget build(BuildContext context) {
    final s = stats;
    final cards = [
      _StatItem('Patient', '${s?.todayPatients ?? 0}', '${s?.totalPatients ?? 0}', true, AppColors.blue),
      _StatItem('Test Booked', '${s?.todayTests ?? 0}', '${s?.totalTests ?? 0}', true, AppColors.splashProgress),
      _StatItem(
        'Collection',
        '₹ ${(s?.todayCollection ?? 0).toStringAsFixed(0)}',
        '₹ ${(s?.totalCollection ?? 0).toStringAsFixed(0)}',
        true,
        AppColors.success,
      ),
      _StatItem('Pending', '', '${s?.pendingReports ?? 0}', false, AppColors.amber),
      _StatItem('Verified', '', '${s?.verifiedReports ?? 0}', false, AppColors.success),
      _StatItem('Doctors', '', '${s?.totalDoctors ?? 0}', false, AppColors.blue),
      _StatItem('Total Due', '', '₹ ${(s?.totalDue ?? 0).toStringAsFixed(0)}', false, AppColors.red),
      _StatItem('Reports', '', '${(s?.verifiedReports ?? 0) + (s?.pendingReports ?? 0)}', false, AppColors.splashAccent),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 1100
            ? 4
            : c.maxWidth >= 820
                ? 3
                : c.maxWidth >= 520
                    ? 2
                    : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 76,
          ),
          itemBuilder: (context, i) {
            final card = cards[i];
            return Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      card.color.withValues(alpha: 0.08),
                      Colors.white,
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: card.color.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(Icons.analytics_outlined, color: card.color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            card.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          if (card.showToday)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: card.today,
                                    style: TextStyle(
                                      color: card.color,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '/${card.total}',
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          else
                            Text(
                              card.total,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
