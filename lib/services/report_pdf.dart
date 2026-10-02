import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';

class ReportPrintOptions {
  const ReportPrintOptions({
    required this.labName,
    required this.showHeader,
    required this.showFooter,
    required this.headerHtml,
    required this.footerHtml,
    this.logoPath = '',
    this.headerHeightMm,
    this.footerHeightMm,
    this.showSectionTitles = true,
    this.reportColorInRange = true,
    this.reportColorOutOfRange = true,
    this.reportFlagLow = true,
    this.reportFlagHigh = true,
    this.fontPatientPt = 9,
    this.fontTestsPt = 9,
    this.fontDescriptionPt = 8,
  });

  final String labName;
  final bool showHeader;
  final bool showFooter;
  final String headerHtml;
  final String footerHtml;
  final String logoPath;
  final int? headerHeightMm;
  final int? footerHeightMm;
  final bool showSectionTitles;
  final bool reportColorInRange;
  final bool reportColorOutOfRange;
  final bool reportFlagLow;
  final bool reportFlagHigh;
  final int fontPatientPt;
  final int fontTestsPt;
  final int fontDescriptionPt;

  /// Same rule for View + Print: toggle on AND non-empty HTML.
  bool get paintHeader => showHeader && headerHtml.trim().isNotEmpty;
  bool get paintFooter => showFooter && footerHtml.trim().isNotEmpty;
}

/// PDF layout aligned with web `resources/views/report/new.blade.php`.
Future<Uint8List> buildReportPdf({
  required ReportPrintOptions options,
  required Patient patient,
  required String referredBy,
  required List<ReportLine> lines,
  PdfPageFormat format = PdfPageFormat.a4,
}) async {
  final fmt = DateFormat('d MMM yyyy');
  final labId = webLabReportId(patient);
  final name = patientDisplayName(patient);

  final order = <String>[];
  final byTest = <String, List<ReportLine>>{};
  final deptByTest = <String, String>{};
  final descByTest = <String, String>{};
  for (final line in lines) {
    if (!byTest.containsKey(line.testName)) {
      order.add(line.testName);
      deptByTest[line.testName] = line.department;
      descByTest[line.testName] = line.description;
    }
    byTest.putIfAbsent(line.testName, () => []).add(line);
  }

  // Build letterhead once; omit entirely when settings toggles are off.
  final headerBlock = options.paintHeader
      ? await _htmlLetterheadPdf(
          options.headerHtml,
          heightMm: options.headerHeightMm,
          logoPath: options.logoPath,
          labLabel: options.labName,
        )
      : null;
  final footerBlock = options.paintFooter
      ? await _htmlLetterheadPdf(
          options.footerHtml,
          heightMm: options.footerHeightMm,
          logoPath: options.logoPath,
          labLabel: options.labName,
        )
      : null;

  final doc = pw.Document();
  final testFont = options.fontTestsPt.clamp(6, 24);
  final descriptionFont = options.fontDescriptionPt.clamp(6, 24);

  doc.addPage(
    pw.MultiPage(
      pageFormat: format,
      margin: const pw.EdgeInsets.fromLTRB(28, 22, 28, 22),
      // Like web <thead>/<tfoot>: repeat when printable toggles are on.
      header: headerBlock == null
          ? null
          : (context) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: headerBlock,
              ),
      footer: footerBlock == null
          ? null
          : (context) => pw.Padding(
                padding: const pw.EdgeInsets.only(top: 8),
                child: footerBlock,
              ),
      build: (context) => [
        pw.Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(1.3),
            1: const pw.FlexColumnWidth(1.7),
            2: const pw.FlexColumnWidth(1.3),
            3: const pw.FlexColumnWidth(1.7),
          },
          children: [
            pw.TableRow(children: [
              _bold('Patient Information'),
              pw.SizedBox(),
              _bold('Specimen Information'),
              pw.SizedBox(),
            ]),
            _detailRow('PETIENT ID', labId, 'COLLECTED:', fmt.format(patient.createdAt)),
            _detailRow('PETIENT NAME:', name, 'REFERED BY:', referredBy.isEmpty ? '—' : referredBy),
            _detailRow('GENDER:', patient.sex.isEmpty ? '—' : patient.sex, 'LAB ID:', labId),
            _detailRow(
              'AGE',
              patient.age == null ? '—' : '${patient.age} Year',
              'COMPLETED:',
              patient.approvedAt == null ? '—' : fmt.format(patient.approvedAt!),
            ),
          ],
        ),
        pw.SizedBox(height: 14),
        for (final testName in order) ...[
          _testBlock(
            department: deptByTest[testName] ?? 'General',
            testName: testName,
            description: descByTest[testName] ?? '',
            lines: byTest[testName]!,
            showSectionTitles: options.showSectionTitles,
            fontTestsPt: testFont,
            fontDescriptionPt: descriptionFont,
            reportColorInRange: options.reportColorInRange,
            reportColorOutOfRange: options.reportColorOutOfRange,
            reportFlagLow: options.reportFlagLow,
            reportFlagHigh: options.reportFlagHigh,
          ),
          pw.SizedBox(height: 12),
        ],
        if (lines.isEmpty)
          pw.Text('No readings yet.', style: pw.TextStyle(color: PdfColors.grey600, fontSize: 10)),
      ],
    ),
  );
  return doc.save();
}

Future<pw.Widget?> _htmlLetterheadPdf(
  String html, {
  int? heightMm,
  String logoPath = '',
  String labLabel = 'Lab',
}) async {
  final trimmed = html.trim();
  if (trimmed.isEmpty) {
    if (logoPath.trim().isEmpty) return null;
    final file = File(logoPath);
    if (!await file.exists()) return null;
    final imgBytes = await file.readAsBytes();
    final headerTitle = labLabel.trim().isEmpty ? 'Lab' : labLabel;
    final content = pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#1e3a6e'),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      padding: const pw.EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: pw.Row(
        children: [
          pw.Image(pw.MemoryImage(imgBytes), width: 42, height: 42, fit: pw.BoxFit.contain),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              headerTitle,
              style: pw.TextStyle(color: PdfColors.white, fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    if (heightMm != null && heightMm > 0) {
      return pw.ConstrainedBox(
        constraints: pw.BoxConstraints(maxHeight: heightMm * PdfPageFormat.mm),
        child: content,
      );
    }
    return content;
  }

  final bg = _firstColor(trimmed) ?? PdfColor.fromHex('#1e3a6e');
  final lines = _htmlTextLines(trimmed);
  final imgBytes = await _firstImageBytes(trimmed);

  pw.Widget? logo;
  if (imgBytes != null) {
    try {
      logo = pw.Image(pw.MemoryImage(imgBytes), width: 42, height: 42, fit: pw.BoxFit.contain);
    } catch (_) {
      logo = null;
    }
  }

  final title = lines.isNotEmpty ? lines.first : '';
  final rest = lines.length > 1 ? lines.sublist(1) : const <String>[];

  // Natural height — forced mm boxes were clipping letterhead blank in print.
  final content = pw.Container(
    width: double.infinity,
    decoration: pw.BoxDecoration(
      color: bg,
      borderRadius: pw.BorderRadius.circular(4),
    ),
    padding: const pw.EdgeInsets.fromLTRB(12, 10, 12, 8),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        if (logo != null) ...[
          logo,
          pw.SizedBox(width: 10),
        ],
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              if (title.isNotEmpty)
                pw.Container(
                  width: double.infinity,
                  color: PdfColors.white,
                  padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: pw.Center(
                    child: pw.Text(
                      title,
                      style: pw.TextStyle(
                        color: bg,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              for (final line in rest.take(4))
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 3),
                  child: pw.Text(
                    line,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 9),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );

  if (heightMm != null && heightMm > 0) {
    // Soft max only — never force a tall empty clip box.
    return pw.ConstrainedBox(
      constraints: pw.BoxConstraints(maxHeight: heightMm * PdfPageFormat.mm),
      child: content,
    );
  }
  return content;
}

PdfColor? _firstColor(String html) {
  final m = RegExp(r'background(?:-color)?:\s*(#[0-9a-fA-F]{3,8})').firstMatch(html);
  if (m == null) return null;
  try {
    return PdfColor.fromHex(m.group(1)!);
  } catch (_) {
    return null;
  }
}

List<String> _htmlTextLines(String html) {
  var s = html
      .replaceAll(RegExp(r'<style[\s\S]*?</style>', caseSensitive: false), ' ')
      .replaceAll(RegExp(r'<!--[\s\S]*?-->'), ' ')
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</(div|p|h[1-6]|li|tr)>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"');
  return s
      .split('\n')
      .map((e) => e.replaceAll(RegExp(r'\s+'), ' ').trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

Future<Uint8List?> _firstImageBytes(String html) async {
  final m = RegExp(r'''src=["']([^"']+)["']''', caseSensitive: false).firstMatch(html);
  if (m == null) return null;
  final src = m.group(1)!;
  try {
    if (src.startsWith('data:image')) {
      final b64 = src.split(',').skip(1).join(',');
      return Uint8List.fromList(base64Decode(b64));
    }
    if (src.startsWith('http://') || src.startsWith('https://')) {
      final client = HttpClient();
      try {
        final req = await client.getUrl(Uri.parse(src)).timeout(const Duration(seconds: 5));
        final res = await req.close().timeout(const Duration(seconds: 5));
        if (res.statusCode >= 200 && res.statusCode < 300) {
          final bytes = await res.fold<List<int>>(<int>[], (a, b) => a..addAll(b));
          return Uint8List.fromList(bytes);
        }
      } finally {
        client.close(force: true);
      }
    }
  } catch (_) {}
  return null;
}

pw.Widget _testBlock({
  required String department,
  required String testName,
  required String description,
  required List<ReportLine> lines,
  required bool showSectionTitles,
  required int fontTestsPt,
  required int fontDescriptionPt,
  required bool reportColorInRange,
  required bool reportColorOutOfRange,
  required bool reportFlagLow,
  required bool reportFlagHigh,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      pw.Container(
        width: double.infinity,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey500, width: 0.6),
          color: PdfColors.grey300,
        ),
        padding: const pw.EdgeInsets.all(6),
        child: pw.Center(
          child: pw.Text(
            department.toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
          ),
        ),
      ),
      pw.Container(
        width: double.infinity,
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            left: pw.BorderSide(color: PdfColors.grey500, width: 0.6),
            right: pw.BorderSide(color: PdfColors.grey500, width: 0.6),
          ),
        ),
        padding: const pw.EdgeInsets.all(6),
        child: pw.Center(
          child: pw.Text(
            testName,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontTestsPt.toDouble()),
          ),
        ),
      ),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey500, width: 0.6),
        columnWidths: {
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(2),
          2: const pw.FlexColumnWidth(1.3),
          3: const pw.FlexColumnWidth(2),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _th('Tests'),
              _th('Result'),
              _th('Units'),
              _th('Reffence Range', center: true),
            ],
          ),
          ..._paramPdfRows(
            lines,
            showSectionTitles: showSectionTitles,
            reportColorInRange: reportColorInRange,
            reportColorOutOfRange: reportColorOutOfRange,
            reportFlagLow: reportFlagLow,
            reportFlagHigh: reportFlagHigh,
            fontTestsPt: fontTestsPt,
            fontDescriptionPt: fontDescriptionPt,
          ),
        ],
      ),
      // Web: <td colspan="4">Descrption:…</td>
      if (description.trim().isNotEmpty)
        pw.Container(
          width: double.infinity,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(color: PdfColors.grey500, width: 0.6),
              right: pw.BorderSide(color: PdfColors.grey500, width: 0.6),
              bottom: pw.BorderSide(color: PdfColors.grey500, width: 0.6),
            ),
          ),
          padding: const pw.EdgeInsets.all(6),
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: 'Descrption:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontDescriptionPt.toDouble()),
                ),
                pw.TextSpan(
                  text: description.trim(),
                  style: pw.TextStyle(fontSize: fontDescriptionPt.toDouble()),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

List<pw.TableRow> _paramPdfRows(
  List<ReportLine> lines, {
    required bool showSectionTitles,
    required bool reportColorInRange,
    required bool reportColorOutOfRange,
    required bool reportFlagLow,
    required bool reportFlagHigh,
    required int fontTestsPt,
    required int fontDescriptionPt,
  }) {
  final rows = <pw.TableRow>[];
  String? lastSection;
  for (final line in lines) {
    final section = line.sectionTitle?.trim();
    final hasSection = section != null && section.isNotEmpty;
    if (showSectionTitles && hasSection && section != lastSection) {
      lastSection = section;
      rows.add(
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                section,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fontTestsPt.toDouble()),
              ),
            ),
            pw.SizedBox(),
            pw.SizedBox(),
            pw.SizedBox(),
          ],
        ),
      );
    } else if (!showSectionTitles || !hasSection) {
      lastSection = null;
    }
    final indent = hasSection;
    rows.add(
      pw.TableRow(
        children: [
          _td(indent ? '    ${line.parameterTitle}' : line.parameterTitle,
              fontSize: fontTestsPt.toDouble()),
          _td(line.value.isEmpty ? '—' : line.value, bold: true, fontSize: fontTestsPt.toDouble()),
          _td(line.unit == '—' ? '' : line.unit, fontSize: fontTestsPt.toDouble()),
          _td(line.refRange.isEmpty ? '—' : line.refRange, center: true, fontSize: fontTestsPt.toDouble()),
        ],
      ),
    );
  }
  return rows;
}

pw.TableRow _detailRow(String k1, String v1, String k2, String v2) {
  return pw.TableRow(
    children: [
      _bold(k1),
      _plain(v1),
      _bold(k2),
      pw.Align(alignment: pw.Alignment.centerRight, child: _plain(v2)),
    ],
  );
}

pw.Widget _bold(String text) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
    );

pw.Widget _plain(String text) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 2),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 9)),
    );

pw.Widget _th(String text, {bool center = false}) => pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
      ),
    );

pw.Widget _td(String text, {bool bold = false, bool center = false, double fontSize = 9}) => pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
