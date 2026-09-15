import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/services/report_pdf.dart';

Patient _patient() => Patient(
      id: 7,
      prefix: 'Mr',
      firstName: 'Test',
      lastName: 'Patient',
      age: 30,
      sex: 'Male',
      phone: '',
      email: '',
      address: '',
      doctorId: null,
      referredBy: 'Self',
      totalAmount: 0,
      discountAmount: 0,
      discountPercent: 0,
      payableAmount: 0,
      paidAmount: 0,
      paymentMethod: '',
      remark: '',
      status: 'Verified',
      approvedAt: DateTime(2026, 9, 14),
      deleteStatus: false,
      createdAt: DateTime(2026, 9, 14, 10),
    );

List<ReportLine> _lines() => [
      ReportLine(
        testName: 'CBC',
        department: 'Hematology',
        description: 'Complete blood count note',
        parameterTitle: 'Hemoglobin',
        value: '13.5',
        unit: 'g/dL',
        refRange: '12-16',
      ),
    ];

void main() {
  const html = '<div style="background-color:#1e3a6e"><div>Jivan Pathology Center</div>'
      '<div>Near Pachahatiya</div></div>';

  test('paintHeader/Footer follow toggles and empty html', () {
    expect(
      const ReportPrintOptions(
        labName: 'Lab',
        showHeader: true,
        showFooter: true,
        headerHtml: html,
        footerHtml: html,
      ).paintHeader,
      isTrue,
    );
    expect(
      const ReportPrintOptions(
        labName: 'Lab',
        showHeader: false,
        showFooter: false,
        headerHtml: html,
        footerHtml: html,
      ).paintHeader,
      isFalse,
    );
    expect(
      const ReportPrintOptions(
        labName: 'Lab',
        showHeader: true,
        showFooter: true,
        headerHtml: '  ',
        footerHtml: '',
      ).paintHeader,
      isFalse,
    );
  });

  test('PDF letterhead included only when toggles on', () async {
    final patient = _patient();
    final lines = _lines();

    final onBytes = await buildReportPdf(
      options: const ReportPrintOptions(
        labName: 'Lab',
        showHeader: true,
        showFooter: true,
        headerHtml: html,
        footerHtml: html,
        headerHeightMm: 65,
        footerHeightMm: 20,
      ),
      patient: patient,
      referredBy: 'Dr X',
      lines: lines,
    );
    final offBytes = await buildReportPdf(
      options: const ReportPrintOptions(
        labName: 'Lab',
        showHeader: false,
        showFooter: false,
        headerHtml: html,
        footerHtml: html,
        headerHeightMm: 65,
        footerHeightMm: 20,
      ),
      patient: patient,
      referredBy: 'Dr X',
      lines: lines,
    );
    final emptyHtmlBytes = await buildReportPdf(
      options: const ReportPrintOptions(
        labName: 'Lab',
        showHeader: true,
        showFooter: true,
        headerHtml: '',
        footerHtml: '',
      ),
      patient: patient,
      referredBy: 'Dr X',
      lines: lines,
    );

    // PDF streams are compressed — compare payload size instead of raw text.
    expect(onBytes.length, greaterThan(offBytes.length));
    expect(offBytes.length, equals(emptyHtmlBytes.length));
  });
}
