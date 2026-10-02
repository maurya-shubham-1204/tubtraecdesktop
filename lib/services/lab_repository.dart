import 'package:drift/drift.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/formula_evaluator.dart';

class DashboardStats {
  DashboardStats({
    required this.totalPatients,
    required this.todayPatients,
    required this.totalTests,
    required this.todayTests,
    required this.totalCollection,
    required this.todayCollection,
    required this.totalDue,
    required this.totalDoctors,
    required this.pendingReports,
    required this.verifiedReports,
  });

  final int totalPatients;
  final int todayPatients;
  final int totalTests;
  final int todayTests;
  final double totalCollection;
  final double todayCollection;
  final double totalDue;
  final int totalDoctors;
  final int pendingReports;
  final int verifiedReports;
}

class BillLine {
  BillLine({required this.test, required this.price});
  final LabTest test;
  final double price;
}

class EntryParameterRow {
  EntryParameterRow({
    required this.patientTestId,
    required this.testId,
    required this.testCode,
    required this.testName,
    required this.department,
    required this.description,
    required this.parameter,
    this.existingValue = '',
  });

  final int patientTestId;
  final int testId;
  final String testCode;
  final String testName;
  final String department;
  final String description;
  final TestParameter parameter;
  final String existingValue;
}

class ReportLine {
  ReportLine({
    required this.testName,
    required this.department,
    required this.description,
    required this.parameterTitle,
    required this.value,
    required this.unit,
    this.refRange = '',
    this.sectionTitle,
  });

  final String testName;
  final String department;
  final String description;
  final String parameterTitle;
  final String value;
  final String unit;
  final String refRange;
  final String? sectionTitle;
}

class AnalyticsSlice {
  AnalyticsSlice({
    required this.from,
    required this.to,
    required this.collection,
    required this.due,
    required this.patientCount,
    required this.testCount,
    required this.commissionTotal,
    required this.volumeByTest,
  });

  final DateTime from;
  final DateTime to;
  final double collection;
  final double due;
  final int patientCount;
  final int testCount;
  final double commissionTotal;
  final List<MapEntry<String, int>> volumeByTest;
}

class LabRepository {
  LabRepository(this.db);
  final AppDatabase db;

  // ---- Doctors ----
  Stream<List<Doctor>> watchDoctors() =>
      (db.select(db.doctors)
            ..where((t) => t.deleteStatus.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.name)]))
          .watch();

  Future<Doctor> ensureSelfDoctor() async {
    final existing = await (db.select(db.doctors)
          ..where((t) => t.isInternal.equals(true) & t.deleteStatus.equals(false))
          ..limit(1))
        .getSingleOrNull();
    if (existing != null) return existing;
    final id = await db.into(db.doctors).insert(
          DoctorsCompanion.insert(
            name: 'Self (Lab)',
            commissionPercent: const Value(0),
            isInternal: const Value(true),
          ),
        );
    return (await (db.select(db.doctors)..where((t) => t.id.equals(id))).getSingle());
  }

  Future<int> addDoctor({
    required String name,
    String phone = '',
    String org = '',
    String email = '',
    String address = '',
    double commission = 0,
  }) {
    return db.into(db.doctors).insert(
          DoctorsCompanion.insert(
            name: name.trim(),
            phone: Value(phone.trim()),
            org: Value(org.trim()),
            email: Value(email.trim()),
            address: Value(address.trim()),
            commissionPercent: Value(commission),
          ),
        );
  }

  Future<void> updateDoctor(Doctor d) {
    return db.update(db.doctors).replace(d);
  }

  Future<void> deleteDoctor(int id) async {
    final d = await (db.select(db.doctors)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (d == null) return;
    if (d.isInternal) {
      throw StateError('Internal Self (Lab) doctor cannot be deleted');
    }
    await (db.update(db.doctors)..where((t) => t.id.equals(id))).write(
      const DoctorsCompanion(deleteStatus: Value(true)),
    );
  }

  Future<void> syncDoctorWallet(int doctorId) async {
    final rows = await (db.select(db.doctorPercents)
          ..where((t) => t.doctorId.equals(doctorId) & t.deleteStatus.equals(false)))
        .get();
    final wallet = rows.fold<double>(0, (sum, row) => sum + row.payableAmount);
    await (db.update(db.doctors)..where((t) => t.id.equals(doctorId))).write(
      DoctorsCompanion(wallet: Value(wallet)),
    );
  }

  Future<void> withdrawDoctorAmount(int doctorId, double amount) async {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0 for withdrawal.');
    }

    final doctor = await (db.select(db.doctors)..where((t) => t.id.equals(doctorId))).getSingleOrNull();
    if (doctor == null) {
      throw StateError('Doctor not found');
    }
    if (doctor.isInternal) {
      throw StateError('Withdrawal is not available for internal Self account.');
    }

    final balance = doctor.wallet;
    if (amount > balance) {
      throw StateError('Withdraw amount cannot exceed current balance (₹${balance.toStringAsFixed(2)}).');
    }

    await db.into(db.doctorPercents).insert(
      DoctorPercentsCompanion.insert(
        patientId: 0,
        doctorId: doctorId,
        amount: const Value(0),
        percent: const Value(0),
        payableAmount: Value(-amount),
      ),
    );

    await (db.update(db.doctors)..where((t) => t.id.equals(doctorId))).write(
      DoctorsCompanion(wallet: Value(balance - amount)),
    );
  }

  Future<double> balanceForDoctor(int doctorId) async {
    final rows = await (db.select(db.doctorPercents)
          ..where((t) => t.doctorId.equals(doctorId) & t.deleteStatus.equals(false)))
        .get();
    return rows.fold<double>(0, (sum, row) => sum + row.payableAmount);
  }

  Future<void> recordDoctorCommission({
    required int patientId,
    required int doctorId,
    required List<int> patientTestIds,
    required List<BillLine> lines,
    required double totalAmount,
    required double discountAmount,
  }) async {
    if (lines.isEmpty || totalAmount <= 0) return;

    final doctor = await (db.select(db.doctors)..where((t) => t.id.equals(doctorId))).getSingleOrNull();
    if (doctor == null || doctor.isInternal) return;

    final hasSummary = await (db.select(db.doctorPercents)
          ..where((t) =>
              t.patientId.equals(patientId) &
              t.doctorId.equals(doctorId) &
              t.deleteStatus.equals(false)))
        .getSingleOrNull();
    if (hasSummary != null) {
      await syncDoctorWallet(doctorId);
      return;
    }

    var totalCommission = 0.0;
    final netBill = (totalAmount - discountAmount).clamp(0, double.infinity).toDouble();
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final share = totalAmount <= 0 ? 0.0 : line.price / totalAmount;
      final netLine = (line.price - discountAmount * share).clamp(0, double.infinity).toDouble();
      final pct = line.test.commissionPercent ?? doctor.commissionPercent;
      totalCommission += netLine * pct / 100;
    }
    totalCommission = double.parse(totalCommission.toStringAsFixed(2));

    final summaryId = await db.into(db.doctorPercents).insert(
      DoctorPercentsCompanion.insert(
        patientId: patientId,
        doctorId: doctorId,
        amount: Value(netBill),
        percent: Value(netBill > 0 ? (totalCommission / netBill * 100) : 0),
        payableAmount: Value(totalCommission),
      ),
    );

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final share = totalAmount <= 0 ? 0.0 : line.price / totalAmount;
      final netLine = (line.price - discountAmount * share).clamp(0, double.infinity).toDouble();
      final pct = line.test.commissionPercent ?? doctor.commissionPercent;
      final commission = (netLine * pct / 100).clamp(0, double.infinity).toDouble();
      await db.into(db.doctorCommissionItems).insert(
        DoctorCommissionItemsCompanion.insert(
          doctorPercentId: summaryId,
          patientTestId: Value(patientTestIds.length > i ? patientTestIds[i] : null),
          testId: line.test.id,
          testName: Value(line.test.name),
          billedAmount: Value(netLine),
          percentApplied: Value(pct),
          commissionAmount: Value(commission),
        ),
      );
    }

    await syncDoctorWallet(doctorId);
  }

  // ---- Tests & parameters ----
  Stream<List<LabTest>> watchTests() =>
      (db.select(db.labTests)
            ..where((t) => t.deleteStatus.equals(false))
            ..orderBy([(t) => OrderingTerm.asc(t.code)]))
          .watch();

  Future<int> addTest({
    required String code,
    required String name,
    String department = 'General',
    double price = 0,
    double maxDisc = 0,
    int params = 1,
  }) {
    return db.into(db.labTests).insert(
          LabTestsCompanion.insert(
            code: code.trim().toUpperCase(),
            name: name.trim(),
            department: Value(department.trim()),
            price: Value(price),
            maxDisc: Value(maxDisc),
            paramCount: Value(params),
          ),
        );
  }

  Future<void> updateTest(LabTest t) => db.update(db.labTests).replace(t);

  Future<void> deleteTest(int id) {
    return (db.update(db.labTests)..where((t) => t.id.equals(id))).write(
      const LabTestsCompanion(deleteStatus: Value(true)),
    );
  }

  Future<List<TestParameter>> parametersForTest(int testId) {
    return (db.select(db.testParameters)
          ..where((t) => t.testId.equals(testId) & t.deleteStatus.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Stream<List<TestParameter>> watchParametersForTest(int testId) {
    return (db.select(db.testParameters)
          ..where((t) => t.testId.equals(testId) & t.deleteStatus.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.id)]))
        .watch();
  }

  Future<int> addParameter({
    required int testId,
    required String title,
    String unit = '',
    String valueType = 'float',
    String formula = '',
    double? groupSumEquals,
    String? sectionTitle,
    int sortOrder = 0,
  }) async {
    final id = await db.into(db.testParameters).insert(
          TestParametersCompanion.insert(
            testId: testId,
            title: title.trim(),
            unit: Value(unit.trim()),
            valueType: Value(valueType),
            formula: Value(formula.trim()),
            groupSumEquals: Value(groupSumEquals),
            sectionTitle: Value(sectionTitle),
            sortOrder: Value(sortOrder),
          ),
        );
    await _syncParamCount(testId);
    return id;
  }

  Future<void> updateParameter(TestParameter p) async {
    await db.update(db.testParameters).replace(p);
    await _syncParamCount(p.testId);
  }

  Future<void> deleteParameter(int id) async {
    final p = await (db.select(db.testParameters)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (p == null) return;
    await (db.update(db.testParameters)..where((t) => t.id.equals(id))).write(
      const TestParametersCompanion(deleteStatus: Value(true)),
    );
    await _syncParamCount(p.testId);
  }

  Future<void> _syncParamCount(int testId) async {
    final rows = await parametersForTest(testId);
    await (db.update(db.labTests)..where((t) => t.id.equals(testId))).write(
      LabTestsCompanion(paramCount: Value(rows.length)),
    );
  }

  // ---- Patients ----
  Stream<List<Patient>> watchPatients() =>
      (db.select(db.patients)
            ..where((t) => t.deleteStatus.equals(false))
            ..orderBy([(t) => OrderingTerm.desc(t.id)]))
          .watch();

  /// Web parity: only billed patients (`total_amount > 0`).
  Stream<List<Patient>> watchBilledPatients() => (db.select(db.patients)
        ..where((t) => t.deleteStatus.equals(false) & t.totalAmount.isBiggerThanValue(0))
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();

  /// Pending queue = non-verified billed patients.
  Stream<List<Patient>> watchPendingPatients() => (db.select(db.patients)
        ..where((t) =>
            t.deleteStatus.equals(false) &
            t.totalAmount.isBiggerThanValue(0) &
            t.status.isNotValue('Verified'))
        ..orderBy([(t) => OrderingTerm.desc(t.id)]))
      .watch();

  Future<Patient?> getPatient(int id) {
    return (db.select(db.patients)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<PatientTest>> testsForPatient(int patientId) {
    return (db.select(db.patientTests)
          ..where((t) => t.patientId.equals(patientId) & t.deleteStatus.equals(false)))
        .get();
  }

  Future<List<TestReading>> readingsForPatient(int patientId) {
    return (db.select(db.testReadings)..where((t) => t.patientId.equals(patientId))).get();
  }

  Future<List<EntryParameterRow>> entryRowsForPatient(int patientId) async {
    final links = await testsForPatient(patientId);
    final readings = await readingsForPatient(patientId);
    final byParam = <int, TestReading>{};
    for (final r in readings) {
      if (r.testParameterId != null) byParam[r.testParameterId!] = r;
    }
    final rows = <EntryParameterRow>[];
    for (final link in links) {
      final test = await (db.select(db.labTests)..where((t) => t.id.equals(link.testId))).getSingleOrNull();
      if (test == null) continue;
      final params = await parametersForTest(link.testId);
      for (final p in params) {
        rows.add(
          EntryParameterRow(
            patientTestId: link.id,
            testId: test.id,
            testCode: test.code,
            testName: test.name,
            department: test.department,
            description: test.description,
            parameter: p,
            existingValue: byParam[p.id]?.value ?? '',
          ),
        );
      }
    }
    return rows;
  }

  Future<List<ReportLine>> reportLinesForPatient(int patientId) async {
    final patient = await getPatient(patientId);
    final rows = await entryRowsForPatient(patientId);
    final readings = await readingsForPatient(patientId);
    final values = <int, String>{};
    for (final r in readings) {
      if (r.testParameterId != null) {
        values[r.testParameterId!] = r.value;
      }
    }
    // Seed non-formula from existing; recalc formulas like web report.
    for (final row in rows) {
      final type = row.parameter.valueType.toLowerCase();
      if (type != 'formula') {
        values.putIfAbsent(row.parameter.id, () => row.existingValue);
      }
    }
    FormulaEvaluator.applyFormulas(
      rows.map((r) => (
            id: r.parameter.id,
            valueType: r.parameter.valueType,
            formula: r.parameter.formula,
          )),
      values,
    );

    final sex = patient?.sex.toLowerCase() ?? '';
    final out = <ReportLine>[];
    for (final row in rows) {
      final p = row.parameter;
      final type = p.valueType.toLowerCase();
      String value;
      if (type == 'formula') {
        final calc = FormulaEvaluator.calculateDisplay(p.formula, values);
        if (calc == null) continue; // hide incomplete formulas
        value = calc;
      } else {
        value = values[p.id] ?? row.existingValue;
        if (value.trim().isEmpty) continue;
      }
      out.add(
        ReportLine(
          testName: row.testName,
          department: row.department,
          description: row.description,
          parameterTitle: p.title,
          value: value,
          unit: p.unit,
          sectionTitle: p.sectionTitle,
          refRange: sex.startsWith('f')
              ? (p.femaleRange.isNotEmpty ? p.femaleRange : p.maleRange)
              : (p.maleRange.isNotEmpty ? p.maleRange : p.femaleRange),
        ),
      );
    }
    return out;
  }

  /// Recalc formulas + validate group sums. Returns error message or null.
  String? prepareReadingsForSave(
    List<EntryParameterRow> rows,
    Map<int, String> values,
  ) {
    FormulaEvaluator.applyFormulas(
      rows.map((r) => (
            id: r.parameter.id,
            valueType: r.parameter.valueType,
            formula: r.parameter.formula,
          )),
      values,
    );
    return FormulaEvaluator.validateGroupSums(
      rows.map((r) => (
            patientTestId: r.patientTestId,
            sectionTitle: r.parameter.sectionTitle,
            groupSumEquals: r.parameter.groupSumEquals,
            parameterId: r.parameter.id,
            valueType: r.parameter.valueType,
          )),
      values,
    );
  }

  Future<int> registerPatient({
    required String prefix,
    required String firstName,
    required String lastName,
    int? age,
    required String sex,
    required String phone,
    String email = '',
    String address = '',
    String remark = '',
    int? doctorId,
    required List<BillLine> lines,
    double discountAmount = 0,
    double discountPercent = 0,
    double? payableAmount,
    required double paidAmount,
    String paymentMethod = 'cash',
  }) async {
    if (lines.isEmpty) {
      throw ArgumentError('At least one test is required');
    }
    final total = lines.fold<double>(0, (s, l) => s + l.price);
    final payable = payableAmount ?? (total - discountAmount).clamp(0, double.infinity);
    final due = payable - paidAmount;
    final status = due > 0.01 ? 'Due' : 'Pending';

    Doctor? doctor;
    if (doctorId != null) {
      doctor = await (db.select(db.doctors)..where((t) => t.id.equals(doctorId))).getSingleOrNull();
    }

    return db.transaction(() async {
      final id = await db.into(db.patients).insert(
            PatientsCompanion.insert(
              prefix: Value(prefix.trim()),
              firstName: firstName.trim(),
              lastName: Value(lastName.trim()),
              age: Value(age),
              sex: Value(sex.trim()),
              phone: Value(phone.trim()),
              email: Value(email.trim()),
              address: Value(address.trim()),
              remark: Value(remark.trim()),
              doctorId: Value(doctorId),
              referredBy: Value(doctor?.name ?? ''),
              totalAmount: Value(total),
              discountAmount: Value(discountAmount),
              discountPercent: Value(discountPercent),
              payableAmount: Value(payable.toDouble()),
              paidAmount: Value(paidAmount),
              paymentMethod: Value(paymentMethod),
              status: Value(status),
            ),
          );

      final insertedPatientTests = <int>[];
      for (final line in lines) {
        final patientTestId = await db.into(db.patientTests).insert(
              PatientTestsCompanion.insert(
                patientId: id,
                testId: line.test.id,
                price: Value(line.price),
              ),
            );
        insertedPatientTests.add(patientTestId);
      }

      if (doctor != null && !doctor.isInternal && doctorId != null) {
        await recordDoctorCommission(
          patientId: id,
          doctorId: doctorId,
          patientTestIds: insertedPatientTests,
          lines: lines,
          totalAmount: total,
          discountAmount: discountAmount,
        );
      }

      return id;
    });
  }

  Future<void> saveReadings({
    required int patientId,
    required List<EntryParameterRow> rows,
    required Map<int, String> valuesByParameterId,
    bool verify = false,
  }) async {
    await db.transaction(() async {
      await (db.delete(db.testReadings)..where((t) => t.patientId.equals(patientId))).go();
      for (final row in rows) {
        final value = valuesByParameterId[row.parameter.id]?.trim() ?? '';
        await db.into(db.testReadings).insert(
              TestReadingsCompanion.insert(
                patientId: patientId,
                patientTestId: Value(row.patientTestId),
                testParameterId: Value(row.parameter.id),
                parameterName: row.parameter.title,
                value: Value(value),
                unit: Value(row.parameter.unit),
              ),
            );
      }
      if (verify) {
        await (db.update(db.patients)..where((t) => t.id.equals(patientId))).write(
          PatientsCompanion(
            status: const Value('Verified'),
            approvedAt: Value(DateTime.now()),
          ),
        );
      } else {
        final p = await getPatient(patientId);
        final due = (p?.payableAmount ?? 0) - (p?.paidAmount ?? 0);
        await (db.update(db.patients)..where((t) => t.id.equals(patientId))).write(
          PatientsCompanion(status: Value(due > 0.01 ? 'Due' : 'Pending')),
        );
      }
    });
  }

  Future<void> verifyPatient(int patientId) async {
    await (db.update(db.patients)..where((t) => t.id.equals(patientId))).write(
      PatientsCompanion(
        status: const Value('Verified'),
        approvedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<DashboardStats> dashboardStats() async {
    final patients = await (db.select(db.patients)
          ..where((t) => t.deleteStatus.equals(false) & t.totalAmount.isBiggerThanValue(0)))
        .get();
    final doctors = await (db.select(db.doctors)..where((t) => t.deleteStatus.equals(false))).get();
    final links = await (db.select(db.patientTests)..where((t) => t.deleteStatus.equals(false))).get();
    final now = DateTime.now();
    bool sameDay(DateTime d) =>
        d.year == now.year && d.month == now.month && d.day == now.day;

    final todayPatients = patients.where((p) => sameDay(p.createdAt)).length;
    final patientIds = patients.map((p) => p.id).toSet();
    final billedLinks = links.where((l) => patientIds.contains(l.patientId)).toList();
    final todayLinks = billedLinks.where((l) => sameDay(l.createdAt)).length;
    final totalCollection = patients.fold<double>(0, (s, p) => s + p.paidAmount);
    final todayCollection = patients
        .where((p) => sameDay(p.createdAt))
        .fold<double>(0, (s, p) => s + p.paidAmount);
    final totalDue = patients.fold<double>(
      0,
      (s, p) => s + (p.payableAmount - p.paidAmount).clamp(0, double.infinity),
    );
    final pending = patients.where((p) => p.status != 'Verified').length;
    final verified = patients.where((p) => p.status == 'Verified').length;

    return DashboardStats(
      totalPatients: patients.length,
      todayPatients: todayPatients,
      totalTests: billedLinks.length,
      todayTests: todayLinks,
      totalCollection: totalCollection,
      todayCollection: todayCollection,
      totalDue: totalDue,
      totalDoctors: doctors.length,
      pendingReports: pending,
      verifiedReports: verified,
    );
  }

  Future<List<MapEntry<String, int>>> topTests({int days = 30}) async {
    final since = DateTime.now().subtract(Duration(days: days));
    final links = await (db.select(db.patientTests)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(since) & t.deleteStatus.equals(false)))
        .get();
    final tests = await db.select(db.labTests).get();
    final byId = {for (final t in tests) t.id: t};
    final counts = <String, int>{};
    for (final l in links) {
      final name = byId[l.testId]?.name ?? 'Unknown';
      counts[name] = (counts[name] ?? 0) + 1;
    }
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(5).toList();
  }

  Future<AnalyticsSlice> analyticsForRange(DateTime from, DateTime to) async {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59);
    final patients = await (db.select(db.patients)
          ..where((t) =>
              t.deleteStatus.equals(false) &
              t.totalAmount.isBiggerThanValue(0) &
              t.createdAt.isBiggerOrEqualValue(start) &
              t.createdAt.isSmallerOrEqualValue(end)))
        .get();
    final links = await (db.select(db.patientTests)..where((t) => t.deleteStatus.equals(false))).get();
    final ids = patients.map((p) => p.id).toSet();
    final inRangeLinks = links.where((l) => ids.contains(l.patientId)).toList();
    final tests = await db.select(db.labTests).get();
    final byId = {for (final t in tests) t.id: t};
    final counts = <String, int>{};
    for (final l in inRangeLinks) {
      final name = byId[l.testId]?.name ?? 'Unknown';
      counts[name] = (counts[name] ?? 0) + 1;
    }
    final volume = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    final commissionLedger = await (db.select(db.doctorPercents)
          ..where((t) =>
              t.deleteStatus.equals(false) &
              t.createdAt.isBiggerOrEqualValue(start) &
              t.createdAt.isSmallerOrEqualValue(end)))
        .get();
    final commissionTotal = commissionLedger.fold<double>(0, (sum, row) => sum + row.payableAmount);

    return AnalyticsSlice(
      from: start,
      to: end,
      collection: patients.fold(0, (s, p) => s + p.paidAmount),
      due: patients.fold(0, (s, p) => s + (p.payableAmount - p.paidAmount).clamp(0, double.infinity)),
      patientCount: patients.length,
      testCount: inRangeLinks.length,
      commissionTotal: commissionTotal,
      volumeByTest: volume,
    );
  }

  String analyticsCsv(AnalyticsSlice slice) {
    final buf = StringBuffer();
    buf.writeln('metric,value');
    buf.writeln('from,${slice.from.toIso8601String()}');
    buf.writeln('to,${slice.to.toIso8601String()}');
    buf.writeln('collection,${slice.collection.toStringAsFixed(2)}');
    buf.writeln('due,${slice.due.toStringAsFixed(2)}');
    buf.writeln('patients,${slice.patientCount}');
    buf.writeln('tests,${slice.testCount}');
    buf.writeln('commission_wallet_total,${slice.commissionTotal.toStringAsFixed(2)}');
    buf.writeln();
    buf.writeln('test,count');
    for (final e in slice.volumeByTest) {
      buf.writeln('"${e.key.replaceAll('"', '""')}",${e.value}');
    }
    return buf.toString();
  }
}

String patientDisplayName(Patient p) {
  return [p.prefix, p.firstName, p.lastName].where((e) => e.trim().isNotEmpty).join(' ');
}

/// Web report ID: `created_at->format('ymdH')` + zero-padded patient id.
String webLabReportId(Patient p) {
  final stamp =
      '${(p.createdAt.year % 100).toString().padLeft(2, '0')}'
      '${p.createdAt.month.toString().padLeft(2, '0')}'
      '${p.createdAt.day.toString().padLeft(2, '0')}'
      '${p.createdAt.hour.toString().padLeft(2, '0')}';
  return '$stamp${p.id.toString().padLeft(3, '0')}';
}

/// Web Completed ↔ desktop Verified.
bool patientIsCompleted(Patient p) => p.status == 'Verified' || p.approvedAt != null;

String patientListStatus(Patient p) {
  if (patientIsCompleted(p)) return 'Completed';
  if (p.status == 'Due') return 'Due';
  return 'Pending';
}
