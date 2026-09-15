import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Local store aligned toward web tenant tables for future .tt sync.
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get labCode => text().withDefault(const Constant(''))();
  TextColumn get licenseKey => text().withDefault(const Constant(''))();
  TextColumn get licenseVer => text().withDefault(const Constant(''))();
  TextColumn get labName => text().withDefault(const Constant('My Lab'))();
  BoolColumn get registered => boolean().withDefault(const Constant(false))();
  BoolColumn get securityEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get passwordHash => text().nullable()();
  TextColumn get passwordSalt => text().nullable()();
  BoolColumn get importPromptDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get registeredAt => dateTime().nullable()();
  /// Match web lab_settings.show_report_header / show_report_footer.
  BoolColumn get showReportHeader => boolean().withDefault(const Constant(true))();
  BoolColumn get showReportFooter => boolean().withDefault(const Constant(true))();
  /// Web `report_header_html` / `report_footer_html` (HTML letterhead).
  TextColumn get reportHeaderHtml => text().withDefault(const Constant(''))();
  TextColumn get reportFooterHtml => text().withDefault(const Constant(''))();
  IntColumn get reportHeaderHeightMm => integer().nullable()();
  IntColumn get reportFooterHeightMm => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Doctors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get org => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  RealColumn get commissionPercent => real().withDefault(const Constant(0))();
  RealColumn get wallet => real().withDefault(const Constant(0))();
  BoolColumn get isInternal => boolean().withDefault(const Constant(false))();
  BoolColumn get deleteStatus => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class LabTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get department => text().withDefault(const Constant('General'))();
  TextColumn get description => text().withDefault(const Constant(''))();
  RealColumn get price => real().withDefault(const Constant(0))();
  RealColumn get maxDisc => real().withDefault(const Constant(0))();
  RealColumn get commissionPercent => real().nullable()();
  IntColumn get paramCount => integer().withDefault(const Constant(1))();
  IntColumn get masterTestId => integer().nullable()();
  BoolColumn get deleteStatus => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TestParameters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get testId => integer().references(LabTests, #id)();
  TextColumn get title => text()();
  TextColumn get unit => text().withDefault(const Constant(''))();
  TextColumn get valueType => text().withDefault(const Constant('float'))();
  TextColumn get formula => text().withDefault(const Constant(''))();
  TextColumn get maleRange => text().withDefault(const Constant(''))();
  TextColumn get femaleRange => text().withDefault(const Constant(''))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get sectionTitle => text().nullable()();
  RealColumn get groupSumEquals => real().nullable()();
  IntColumn get masterParameterId => integer().nullable()();
  BoolColumn get deleteStatus => boolean().withDefault(const Constant(false))();
}

class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get prefix => text().withDefault(const Constant(''))();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().withDefault(const Constant(''))();
  IntColumn get age => integer().nullable()();
  TextColumn get sex => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  IntColumn get doctorId => integer().nullable().references(Doctors, #id)();
  TextColumn get referredBy => text().withDefault(const Constant(''))();
  RealColumn get totalAmount => real().withDefault(const Constant(0))();
  RealColumn get discountAmount => real().withDefault(const Constant(0))();
  RealColumn get discountPercent => real().withDefault(const Constant(0))();
  RealColumn get payableAmount => real().withDefault(const Constant(0))();
  RealColumn get paidAmount => real().withDefault(const Constant(0))();
  TextColumn get paymentMethod => text().withDefault(const Constant(''))();
  TextColumn get remark => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('Pending'))(); // Pending | Due | Verified
  DateTimeColumn get approvedAt => dateTime().nullable()();
  BoolColumn get deleteStatus => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PatientTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  IntColumn get testId => integer().references(LabTests, #id)();
  RealColumn get price => real().withDefault(const Constant(0))();
  BoolColumn get deleteStatus => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class TestReadings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  IntColumn get patientTestId => integer().nullable().references(PatientTests, #id)();
  IntColumn get testParameterId => integer().nullable().references(TestParameters, #id)();
  TextColumn get parameterName => text()();
  TextColumn get value => text().withDefault(const Constant(''))();
  TextColumn get unit => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [
  AppSettings,
  Doctors,
  LabTests,
  TestParameters,
  Patients,
  PatientTests,
  TestReadings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(doctors, doctors.org);
            await m.addColumn(doctors, doctors.email);
            await m.addColumn(doctors, doctors.address);
            await m.addColumn(doctors, doctors.isInternal);
            await m.addColumn(doctors, doctors.deleteStatus);

            await m.addColumn(labTests, labTests.description);
            await m.addColumn(labTests, labTests.maxDisc);
            await m.addColumn(labTests, labTests.commissionPercent);
            await m.addColumn(labTests, labTests.masterTestId);
            await m.addColumn(labTests, labTests.deleteStatus);

            await m.createTable(testParameters);

            await m.addColumn(patients, patients.email);
            await m.addColumn(patients, patients.address);
            await m.addColumn(patients, patients.referredBy);
            await m.addColumn(patients, patients.discountAmount);
            await m.addColumn(patients, patients.discountPercent);
            await m.addColumn(patients, patients.payableAmount);
            await m.addColumn(patients, patients.paymentMethod);
            await m.addColumn(patients, patients.remark);
            await m.addColumn(patients, patients.deleteStatus);

            await m.addColumn(patientTests, patientTests.deleteStatus);

            await m.addColumn(testReadings, testReadings.patientTestId);
            await m.addColumn(testReadings, testReadings.testParameterId);
          }
          if (from < 3) {
            await m.addColumn(testParameters, testParameters.formula);
            await m.addColumn(testParameters, testParameters.groupSumEquals);
          }
          if (from < 4) {
            await m.addColumn(appSettings, appSettings.showReportHeader);
            await m.addColumn(appSettings, appSettings.showReportFooter);
          }
          if (from < 5) {
            Future<void> addIfMissing(TableInfo table, GeneratedColumn col) async {
              try {
                await m.addColumn(table, col);
              } catch (_) {
                // Already present (manual patch / re-run).
              }
            }

            await addIfMissing(appSettings, appSettings.reportHeaderHtml);
            await addIfMissing(appSettings, appSettings.reportFooterHtml);
            await addIfMissing(appSettings, appSettings.reportHeaderHeightMm);
            await addIfMissing(appSettings, appSettings.reportFooterHeightMm);
            // Copy from brief v4 plain-text columns if they exist.
            try {
              await customStatement('''
                UPDATE app_settings SET
                  report_header_html = CASE
                    WHEN COALESCE(report_header_html, '') = ''
                    THEN COALESCE(report_header_text, '')
                    ELSE report_header_html END,
                  report_footer_html = CASE
                    WHEN COALESCE(report_footer_html, '') = ''
                    THEN COALESCE(report_footer_text, '')
                    ELSE report_footer_html END
              ''');
            } catch (_) {}
          }
        },
      );

  Future<AppSetting> ensureSettingsRow() async {
    final existing = await select(appSettings).getSingleOrNull();
    if (existing != null) return existing;
    await into(appSettings).insert(AppSettingsCompanion.insert(id: const Value(1)));
    return (await select(appSettings).getSingle());
  }

  Future<void> seedDefaultsIfEmpty() async {
    await ensureSettingsRow();
    // Always ensure internal Self doctor (even if catalog already seeded).
    final self = await (select(doctors)
          ..where((t) => t.isInternal.equals(true) & t.deleteStatus.equals(false))
          ..limit(1))
        .getSingleOrNull();
    if (self == null) {
      await into(doctors).insert(
        DoctorsCompanion.insert(
          name: 'Self (Lab)',
          commissionPercent: const Value(0),
          isInternal: const Value(true),
        ),
      );
    }

    final testCount = await (select(labTests)..limit(1)).get();
    if (testCount.isNotEmpty) return;

    await batch((b) {
      b.insertAll(labTests, [
        LabTestsCompanion.insert(code: 'CBC', name: 'Complete Blood Count', department: const Value('Hematology'), price: const Value(350), paramCount: const Value(4)),
        LabTestsCompanion.insert(code: 'LFT', name: 'Liver Function Test', department: const Value('Biochemistry'), price: const Value(650), paramCount: const Value(3)),
        LabTestsCompanion.insert(code: 'KFT', name: 'Kidney Function Test', department: const Value('Biochemistry'), price: const Value(550), paramCount: const Value(3)),
        LabTestsCompanion.insert(code: 'LIPID', name: 'Lipid Profile', department: const Value('Biochemistry'), price: const Value(500), paramCount: const Value(4)),
        LabTestsCompanion.insert(code: 'TSH', name: 'Thyroid Stimulating Hormone', department: const Value('Hormones'), price: const Value(400), paramCount: const Value(1)),
      ]);
      b.insertAll(doctors, [
        DoctorsCompanion.insert(name: 'Dr. Mehta', phone: const Value('9876543210'), commissionPercent: const Value(20), wallet: const Value(0)),
        DoctorsCompanion.insert(name: 'Dr. Kapoor', phone: const Value('9811122334'), commissionPercent: const Value(15), wallet: const Value(0)),
        DoctorsCompanion.insert(name: 'Dr. Khan', phone: const Value('9900011223'), commissionPercent: const Value(18), wallet: const Value(0)),
      ]);
    });

    final tests = await select(labTests).get();
    final byCode = {for (final t in tests) t.code: t};
    Future<void> params(String code, List<(String, String)> rows) async {
      final t = byCode[code];
      if (t == null) return;
      var order = 0;
      for (final row in rows) {
        await into(testParameters).insert(
          TestParametersCompanion.insert(
            testId: t.id,
            title: row.$1,
            unit: Value(row.$2),
            sortOrder: Value(order++),
          ),
        );
      }
    }

    await params('CBC', [('Hemoglobin', 'g/dL'), ('WBC', '10^3/uL'), ('RBC', '10^6/uL'), ('Platelets', '10^3/uL')]);
    await params('LFT', [('Bilirubin Total', 'mg/dL'), ('SGOT', 'U/L'), ('SGPT', 'U/L')]);
    await params('KFT', [('Urea', 'mg/dL'), ('Creatinine', 'mg/dL'), ('Uric Acid', 'mg/dL')]);
    await params('LIPID', [('Cholesterol', 'mg/dL'), ('Triglycerides', 'mg/dL'), ('HDL', 'mg/dL'), ('LDL', 'mg/dL')]);
    await params('TSH', [('TSH', 'uIU/mL')]);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'tubtrace_offline.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

Future<String> databaseFilePath() async {
  final dir = await getApplicationSupportDirectory();
  return p.join(dir.path, 'tubtrace_offline.sqlite');
}
