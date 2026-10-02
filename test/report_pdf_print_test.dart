import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/services/portable_pack.dart';
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

  test('report settings include web parity fields for layout and flags', () {
    const options = ReportPrintOptions(
      labName: 'Lab',
      showHeader: true,
      showFooter: true,
      headerHtml: html,
      footerHtml: html,
      showSectionTitles: true,
      reportColorInRange: true,
      reportColorOutOfRange: true,
      reportFlagLow: true,
      reportFlagHigh: true,
      fontPatientPt: 9,
      fontTestsPt: 9,
      fontDescriptionPt: 8,
    );

    expect(options.showSectionTitles, isTrue);
    expect(options.reportColorInRange, isTrue);
    expect(options.reportFlagLow, isTrue);
    expect(options.reportFlagHigh, isTrue);
    expect(options.fontPatientPt, equals(9));
    expect(options.fontDescriptionPt, equals(8));
  });

  test('portable backup retains web lab profile fields', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    await db.into(db.appSettings).insert(
      AppSettingsCompanion(
        id: const Value(1),
        labCode: const Value('LAB-001'),
        labName: const Value('Jivan Lab'),
        address: const Value('Main Road, Nagpur'),
        contact: const Value('+91 98765 43210'),
        email: const Value('lab@example.com'),
        websiteUrl: const Value('https://example.com'),
        additionalInfo: const Value('Pathology center'),
        defaultDoctorCommissionPercent: const Value(15),
        reportHeaderHtml: const Value('<div>Header</div>'),
        reportFooterHtml: const Value('<div>Footer</div>'),
      ),
    );

    final pack = await PortablePack.exportJson(db);
    final manifest = pack['manifest'] as Map<String, dynamic>;

    expect(manifest['lab_name'], 'Jivan Lab');
    expect(manifest['address'], 'Main Road, Nagpur');
    expect(manifest['email'], 'lab@example.com');
    expect(manifest['website_url'], 'https://example.com');
    expect(manifest['default_doctor_commission_percent'], 15);
  });

  test('doctor wallet is synced from commission ledger and the same fields as web', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    final repo = LabRepository(db);
    final doctorId = await db.into(db.doctors).insert(
      DoctorsCompanion.insert(
        name: 'Dr. Mehta',
        commissionPercent: const Value(10),
        wallet: const Value(0),
        isInternal: const Value(false),
      ),
    );
    final testId = await db.into(db.labTests).insert(
      LabTestsCompanion.insert(
        code: 'CBC',
        name: 'CBC',
        price: const Value(1000),
        commissionPercent: const Value(10),
      ),
    );
    final patientId = await db.into(db.patients).insert(
      PatientsCompanion.insert(
        firstName: 'Jane',
        sex: const Value('Female'),
        doctorId: Value(doctorId),
        referredBy: const Value('Dr. Mehta'),
        totalAmount: const Value(1000),
        payableAmount: const Value(1000),
        paidAmount: const Value(1000),
      ),
    );

    final patientTestId = await db.into(db.patientTests).insert(
      PatientTestsCompanion.insert(
        patientId: patientId,
        testId: testId,
        price: const Value(1000),
      ),
    );

    await repo.recordDoctorCommission(
      patientId: patientId,
      doctorId: doctorId,
      patientTestIds: [patientTestId],
      totalAmount: 1000,
      discountAmount: 0,
      lines: [
        BillLine(
          test: LabTest(
            id: testId,
            code: 'CBC',
            name: 'CBC',
            department: 'General',
            description: '',
            price: 1000,
            maxDisc: 0,
            commissionPercent: 10,
            paramCount: 1,
            masterTestId: null,
            deleteStatus: false,
            createdAt: DateTime.now(),
          ),
          price: 1000,
        ),
      ],
    );

    final summary = await (db.select(db.doctorPercents)
          ..where((t) => t.patientId.equals(patientId) & t.doctorId.equals(doctorId)))
        .get();
    final items = await (db.select(db.doctorCommissionItems)
          ..where((t) => t.doctorPercentId.equals(summary.first.id)))
        .get();

    expect(summary, hasLength(1));
    expect(summary.first.payableAmount, closeTo(100, 0.01));
    expect(items, hasLength(1));
    expect(items.first.commissionAmount, closeTo(100, 0.01));

    final doctor = await (db.select(db.doctors)..where((t) => t.id.equals(doctorId))).getSingle();
    expect(doctor.wallet, closeTo(100, 0.01));
  });

  test('analytics commission totals use the ledger for the selected range', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    final doctorId = await db.into(db.doctors).insert(
      DoctorsCompanion.insert(
        name: 'Dr. Ledger',
        commissionPercent: const Value(10),
        wallet: const Value(999),
        isInternal: const Value(false),
      ),
    );
    await db.into(db.doctorPercents).insert(
      DoctorPercentsCompanion.insert(
        patientId: 1,
        doctorId: doctorId,
        amount: const Value(1000),
        percent: const Value(10),
        payableAmount: const Value(100),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 2))),
      ),
    );
    await db.into(db.doctorPercents).insert(
      DoctorPercentsCompanion.insert(
        patientId: 2,
        doctorId: doctorId,
        amount: const Value(2000),
        percent: const Value(10),
        payableAmount: const Value(250),
        createdAt: Value(DateTime.now().add(const Duration(days: 30))),
      ),
    );

    final repo = LabRepository(db);
    final slice = await repo.analyticsForRange(
      DateTime.now().subtract(const Duration(days: 7)),
      DateTime.now().add(const Duration(days: 7)),
    );

    expect(slice.commissionTotal, closeTo(100, 0.01));
  });

  test('doctor withdrawal records a negative ledger entry and reduces wallet', () async {
    final db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    final repo = LabRepository(db);
    final doctorId = await db.into(db.doctors).insert(
      DoctorsCompanion.insert(
        name: 'Dr. Withdraw',
        commissionPercent: const Value(10),
        wallet: const Value(500),
        isInternal: const Value(false),
      ),
    );

    await repo.withdrawDoctorAmount(doctorId, 150);

    final ledger = await (db.select(db.doctorPercents)
          ..where((t) => t.doctorId.equals(doctorId) & t.patientId.equals(0)))
        .get();
    final updated = await (db.select(db.doctors)..where((t) => t.id.equals(doctorId))).getSingle();

    expect(ledger, hasLength(1));
    expect(ledger.first.payableAmount, closeTo(-150, 0.01));
    expect(updated.wallet, closeTo(350, 0.01));
  });
}
