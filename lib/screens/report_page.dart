import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/services/report_pdf.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/report_letterhead.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({
    super.key,
    required this.patientId,
    this.autoPrint = false,
    this.onNavigate,
  });

  final int? patientId;
  final bool autoPrint;
  final ShellNavigate? onNavigate;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool _loading = true;
  bool _printing = false;
  String? _error;
  AppSetting? _settings;
  String _referredBy = '';
  Patient? _patient;
  List<ReportLine> _lines = const [];
  bool _didAutoPrint = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void didUpdateWidget(covariant ReportPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patientId != widget.patientId || oldWidget.autoPrint != widget.autoPrint) {
      _didAutoPrint = false;
      _load();
    }
  }

  Future<ReportPrintOptions> _freshPrintOptions() async {
    final s = await AppScope.of(context).auth.settings();
    if (mounted) setState(() => _settings = s);
    return ReportPrintOptions(
      labName: s.labName,
      showHeader: s.showReportHeader,
      showFooter: s.showReportFooter,
      headerHtml: s.reportHeaderHtml,
      footerHtml: s.reportFooterHtml,
      logoPath: s.logoPath,
      headerHeightMm: s.reportHeaderHeightMm,
      footerHeightMm: s.reportFooterHeightMm,
      showSectionTitles: s.showReportSectionTitles,
      reportColorInRange: s.reportColorInRange,
      reportColorOutOfRange: s.reportColorOutOfRange,
      reportFlagLow: s.reportFlagLow,
      reportFlagHigh: s.reportFlagHigh,
      fontPatientPt: s.reportFontPatientPt ?? 9,
      fontTestsPt: s.reportFontTestsPt ?? 9,
      fontDescriptionPt: s.reportFontDescriptionPt ?? 8,
    );
  }

  Future<void> _load() async {
    final id = widget.patientId;
    if (id == null) {
      setState(() {
        _loading = false;
        _error = 'No patient selected';
      });
      return;
    }
    try {
      final scope = AppScope.of(context);
      final repo = LabRepository(scope.db);
      final settings = await scope.auth.settings();
      final patient = await repo.getPatient(id);
      if (patient == null) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _error = 'Patient not found';
        });
        return;
      }

      var referred = patient.referredBy;
      if (referred.isEmpty && patient.doctorId != null) {
        final doctors = await scope.db.select(scope.db.doctors).get();
        for (final d in doctors) {
          if (d.id == patient.doctorId) {
            referred = d.isInternal ? 'Self (Lab)' : d.name;
            break;
          }
        }
      }

      final lines = await repo.reportLinesForPatient(id);
      if (!mounted) return;
      setState(() {
        _settings = settings;
        _patient = patient;
        _referredBy = referred;
        _lines = lines;
        _loading = false;
        _error = null;
      });

      if (widget.autoPrint && !_didAutoPrint) {
        _didAutoPrint = true;
        await Future<void>.delayed(const Duration(milliseconds: 200));
        if (mounted) await _print();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Failed to load report: $e';
      });
    }
  }

  ReportPrintOptions get _printOptions {
    final s = _settings;
    return ReportPrintOptions(
      labName: s?.labName ?? 'Lab',
      showHeader: s?.showReportHeader ?? true,
      showFooter: s?.showReportFooter ?? true,
      headerHtml: s?.reportHeaderHtml ?? '',
      footerHtml: s?.reportFooterHtml ?? '',
      logoPath: s?.logoPath ?? '',
      headerHeightMm: s?.reportHeaderHeightMm,
      footerHeightMm: s?.reportFooterHeightMm,
      showSectionTitles: s?.showReportSectionTitles ?? true,
      reportColorInRange: s?.reportColorInRange ?? true,
      reportColorOutOfRange: s?.reportColorOutOfRange ?? true,
      reportFlagLow: s?.reportFlagLow ?? true,
      reportFlagHigh: s?.reportFlagHigh ?? true,
      fontPatientPt: s?.reportFontPatientPt ?? 9,
      fontTestsPt: s?.reportFontTestsPt ?? 9,
      fontDescriptionPt: s?.reportFontDescriptionPt ?? 8,
    );
  }

  Future<void> _print() async {
    final patient = _patient;
    if (patient == null || _printing) return;
    setState(() => _printing = true);
    try {
      // Always re-read settings so Print matches current toggles.
      final options = await _freshPrintOptions();
      if (!mounted) return;

      // Build once — Printing.layoutPdf may call onLayout multiple times.
      final bytes = await buildReportPdf(
        options: options,
        patient: patient,
        referredBy: _referredBy,
        lines: _lines,
      );
      if (!mounted) return;

      await Printing.layoutPdf(
        name: 'TubTrace report P-${patient.id}',
        onLayout: (_) async => bytes,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Print failed: $e')));
    } finally {
      if (mounted) setState(() => _printing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      child: _loading
          ? const SizedBox(height: 240, child: Center(child: CircularProgressIndicator()))
          : _error != null
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(_error!, style: const TextStyle(color: AppColors.muted)),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: AppColors.headerWash,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton.icon(
                              onPressed: _printing ? null : _print,
                              icon: _printing
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.print_outlined),
                              label: Text(_printing ? 'Printing…' : 'Print'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => widget.onNavigate?.call(AppSection.patients),
                              icon: const Icon(Icons.close),
                              label: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (_printOptions.paintHeader) ...[
                              ReportLetterheadHtml(
                                html: _printOptions.headerHtml,
                                heightMm: _printOptions.headerHeightMm,
                              ),
                              const SizedBox(height: 12),
                            ],
                            _patientInfoTable(),
                            const SizedBox(height: 16),
                            if (_lines.isEmpty)
                              const Text('No readings yet.', style: TextStyle(color: AppColors.muted))
                            else
                              ..._buildTestBlocks(),
                            if (_printOptions.paintFooter) ...[
                              const SizedBox(height: 12),
                              ReportLetterheadHtml(
                                html: _printOptions.footerHtml,
                                heightMm: _printOptions.footerHeightMm,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _patientInfoTable() {
    final p = _patient!;
    final fmt = DateFormat('d MMM yyyy');
    final labId = webLabReportId(p);
    Widget cell(String text, {bool header = false, bool right = false}) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(
            text,
            textAlign: right ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              fontWeight: header ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        );

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.3),
        1: FlexColumnWidth(1.7),
        2: FlexColumnWidth(1.3),
        3: FlexColumnWidth(1.7),
      },
      children: [
        TableRow(children: [
          cell('Patient Information', header: true),
          cell(''),
          cell('Specimen Information', header: true),
          cell(''),
        ]),
        TableRow(children: [
          cell('PETIENT ID', header: true),
          cell(labId),
          cell('COLLECTED:', header: true),
          cell(fmt.format(p.createdAt), right: true),
        ]),
        TableRow(children: [
          cell('PETIENT NAME:', header: true),
          cell(patientDisplayName(p)),
          cell('REFERED BY:', header: true),
          cell(_referredBy.isEmpty ? '—' : _referredBy, right: true),
        ]),
        TableRow(children: [
          cell('GENDER:', header: true),
          cell(p.sex.isEmpty ? '—' : p.sex),
          cell('LAB ID:', header: true),
          cell(labId, right: true),
        ]),
        TableRow(children: [
          cell('AGE', header: true),
          cell(p.age == null ? '—' : '${p.age} Year'),
          cell('COMPLETED:', header: true),
          cell(p.approvedAt == null ? '—' : fmt.format(p.approvedAt!), right: true),
        ]),
      ],
    );
  }

  List<Widget> _buildTestBlocks() {
    final order = <String>[];
    final byTest = <String, List<ReportLine>>{};
    final dept = <String, String>{};
    final desc = <String, String>{};
    for (final line in _lines) {
      if (!byTest.containsKey(line.testName)) {
        order.add(line.testName);
        dept[line.testName] = line.department;
        desc[line.testName] = line.description;
      }
      byTest.putIfAbsent(line.testName, () => []).add(line);
    }

    return [
      for (final name in order)
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: const Color(0xFFE9ECEF),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  (dept[name] ?? 'General').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
              Table(
                border: TableBorder.symmetric(inside: const BorderSide(color: AppColors.border)),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(color: Color(0xFFF8F9FA)),
                    children: [
                      _Th('Tests'),
                      _Th('Result'),
                      _Th('Units'),
                      _Th('Reffence Range', center: true),
                    ],
                  ),
                  ..._paramRows(byTest[name]!),
                ],
              ),
              // Web: <td colspan="4">Descrption:…</td> — full width under the grid.
              if ((desc[name] ?? '').trim().isNotEmpty)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Descrption:',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                        ),
                        TextSpan(
                          text: desc[name]!.trim(),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
    ];
  }

  List<TableRow> _paramRows(List<ReportLine> lines) {
    final rows = <TableRow>[];
    String? lastSection;
    for (final line in lines) {
      final section = line.sectionTitle?.trim();
      if (section != null && section.isNotEmpty && section != lastSection) {
        lastSection = section;
        rows.add(
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(section, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ],
          ),
        );
      }
      final indent = section != null && section.isNotEmpty;
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(indent ? 20 : 8, 8, 8, 8),
              child: Text(line.parameterTitle, style: const TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                line.value.isEmpty ? '—' : line.value,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                line.unit == '—' ? '' : line.unit,
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                line.refRange.isEmpty ? '—' : line.refRange,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ),
          ],
        ),
      );
    }
    return rows;
  }
}

class _Th extends StatelessWidget {
  const _Th(this.label, {this.center = false});
  final String label;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        label,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
