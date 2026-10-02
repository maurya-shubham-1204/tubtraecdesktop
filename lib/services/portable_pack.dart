import 'package:drift/drift.dart';
import 'package:tubtrace_desktop/db/app_database.dart';

/// Web-aligned JSON document used inside encrypted .tt archives.
/// Field names intentionally mirror Laravel tenant tables for future sync.
class PortablePack {
  static const schema = 'tubtrace.portable';
  static const version = 1;

  static Future<Map<String, dynamic>> exportJson(AppDatabase db) async {
    final settings = await db.ensureSettingsRow();
    final doctors = await db.select(db.doctors).get();
    final tests = await db.select(db.labTests).get();
    final params = await db.select(db.testParameters).get();
    final patients = await db.select(db.patients).get();
    final patientTests = await db.select(db.patientTests).get();
    final readings = await db.select(db.testReadings).get();
    final doctorPercents = await db.select(db.doctorPercents).get();
    final doctorCommissionItems = await db.select(db.doctorCommissionItems).get();

    return {
      'format': schema,
      'version': version,
      'exported_at': DateTime.now().toUtc().toIso8601String(),
      'manifest': {
        'lab_code': settings.labCode,
        'org_name': settings.labName,
        'lab_name': settings.labName,
        'address': settings.address,
        'contact': settings.contact,
        'email': settings.email,
        'website_url': settings.websiteUrl,
        'additional_info': settings.additionalInfo,
        'logo_path': settings.logoPath,
        'default_doctor_commission_percent': settings.defaultDoctorCommissionPercent,
        'license_key': settings.licenseKey,
        'license_ver': settings.licenseVer,
        'registered': settings.registered,
        'registered_at': settings.registeredAt?.toUtc().toIso8601String(),
        'security_enabled': settings.securityEnabled,
        'password_hash': settings.passwordHash,
        'password_salt': settings.passwordSalt,
        'import_prompt_done': settings.importPromptDone,
        'show_report_header': settings.showReportHeader,
        'show_report_footer': settings.showReportFooter,
        'show_report_section_titles': settings.showReportSectionTitles,
        'report_font_patient_pt': settings.reportFontPatientPt,
        'report_font_tests_pt': settings.reportFontTestsPt,
        'report_font_description_pt': settings.reportFontDescriptionPt,
        'report_color_in_range': settings.reportColorInRange,
        'report_color_out_of_range': settings.reportColorOutOfRange,
        'report_flag_low': settings.reportFlagLow,
        'report_flag_high': settings.reportFlagHigh,
        'report_header_html': settings.reportHeaderHtml,
        'report_footer_html': settings.reportFooterHtml,
        'report_header_height_mm': settings.reportHeaderHeightMm,
        'report_footer_height_mm': settings.reportFooterHeightMm,
      },
      'doctors': [
        for (final d in doctors)
          {
            'id': d.id,
            'name': d.name,
            'org': d.org,
            'email': d.email,
            'phone': d.phone,
            'address': d.address,
            'commission': d.commissionPercent,
            'wallet': d.wallet,
            'is_internal': d.isInternal,
            'delete_status': d.deleteStatus,
            'created_at': d.createdAt.toUtc().toIso8601String(),
          },
      ],
      'tests': [
        for (final t in tests)
          {
            'id': t.id,
            'test_code': t.code,
            'test_name': t.name,
            'department': t.department,
            'description': t.description,
            'price': t.price,
            'maxDisc': t.maxDisc,
            'commission_percent': t.commissionPercent,
            'param_count': t.paramCount,
            'master_test_id': t.masterTestId,
            'delete_status': t.deleteStatus,
            'created_at': t.createdAt.toUtc().toIso8601String(),
          },
      ],
      'test_parameters': [
        for (final p in params)
          {
            'id': p.id,
            'tests_id': p.testId,
            'title': p.title,
            'unit': p.unit,
            'value_type': p.valueType,
            'formula': p.formula,
            'male_range': p.maleRange,
            'female_range': p.femaleRange,
            'order': p.sortOrder,
            'section_title': p.sectionTitle,
            'group_sum_equals': p.groupSumEquals,
            'master_parameter_id': p.masterParameterId,
            'delete_status': p.deleteStatus,
          },
      ],
      'patients': [
        for (final p in patients)
          {
            'id': p.id,
            'pre_name': p.prefix,
            'first_name': p.firstName,
            'second_name': p.lastName,
            'age': p.age,
            'gender': p.sex,
            'mobile': p.phone,
            'email': p.email,
            'address': p.address,
            'reffered_by': p.doctorId,
            'referred_by_text': p.referredBy,
            'total_amount': p.totalAmount,
            'Discount_amount': p.discountAmount,
            'Discount_percent': p.discountPercent,
            'payable_amount': p.payableAmount > 0 ? p.payableAmount : p.totalAmount,
            'paid_amount': p.paidAmount,
            'payment_method': p.paymentMethod,
            'remark': p.remark,
            'workflow_status': p.status,
            'approved_at': p.approvedAt?.toUtc().toIso8601String(),
            'delete_status': p.deleteStatus,
            'created_at': p.createdAt.toUtc().toIso8601String(),
          },
      ],
      'patient_tests': [
        for (final pt in patientTests)
          {
            'id': pt.id,
            'patient_id': pt.patientId,
            'test_id': pt.testId,
            'test_price': pt.price,
            'delete_status': pt.deleteStatus,
            'created_at': pt.createdAt.toUtc().toIso8601String(),
          },
      ],
      'test_readings': [
        for (final r in readings)
          {
            'id': r.id,
            'patient_id': r.patientId,
            'patient_test_id': r.patientTestId,
            'test_parameter_id': r.testParameterId,
            'parameter_name': r.parameterName,
            'reading': r.value,
            'unit': r.unit,
            'updated_at': r.updatedAt.toUtc().toIso8601String(),
          },
      ],
      'doctor_percent': [
        for (final s in doctorPercents)
          {
            'id': s.id,
            'patient_id': s.patientId,
            'doctor_id': s.doctorId,
            'amount': s.amount,
            'percent': s.percent,
            'payable_amount': s.payableAmount,
            'status': s.status,
            'delete_status': s.deleteStatus,
            'created_at': s.createdAt.toUtc().toIso8601String(),
          },
      ],
      'doctor_commission_items': [
        for (final i in doctorCommissionItems)
          {
            'id': i.id,
            'doctor_percent_id': i.doctorPercentId,
            'patient_test_id': i.patientTestId,
            'test_id': i.testId,
            'test_name': i.testName,
            'billed_amount': i.billedAmount,
            'percent_applied': i.percentApplied,
            'commission_amount': i.commissionAmount,
            'status': i.status,
            'delete_status': i.deleteStatus,
            'created_at': i.createdAt.toUtc().toIso8601String(),
          },
      ],
    };
  }

  static Future<void> importJson(AppDatabase db, Map<String, dynamic> root) async {
    final format = root['format'];
    final version = root['version'];
    if (format != schema) {
      throw const FormatException('Unsupported portable format.');
    }
    if (version is! int || version < 1) {
      throw const FormatException('Unsupported portable version.');
    }

    final manifest = Map<String, dynamic>.from(root['manifest'] as Map? ?? {});
    final doctors = (root['doctors'] as List? ?? const []).cast<dynamic>();
    final tests = (root['tests'] as List? ?? const []).cast<dynamic>();
    final params = (root['test_parameters'] as List? ?? const []).cast<dynamic>();
    final patients = (root['patients'] as List? ?? const []).cast<dynamic>();
    final patientTests = (root['patient_tests'] as List? ?? const []).cast<dynamic>();
    final readings = (root['test_readings'] as List? ?? const []).cast<dynamic>();
    final doctorPercents = (root['doctor_percent'] as List? ?? const []).cast<dynamic>();
    final doctorCommissionItems = (root['doctor_commission_items'] as List? ?? const []).cast<dynamic>();

    await db.transaction(() async {
      await db.delete(db.doctorCommissionItems).go();
      await db.delete(db.doctorPercents).go();
      await db.delete(db.testReadings).go();
      await db.delete(db.patientTests).go();
      await db.delete(db.patients).go();
      await db.delete(db.testParameters).go();
      await db.delete(db.labTests).go();
      await db.delete(db.doctors).go();

      await db.into(db.appSettings).insertOnConflictUpdate(
            AppSettingsCompanion(
              id: const Value(1),
              labCode: Value('${manifest['lab_code'] ?? ''}'),
              licenseKey: Value('${manifest['license_key'] ?? ''}'),
              licenseVer: Value('${manifest['license_ver'] ?? ''}'),
              labName: Value('${manifest['lab_name'] ?? manifest['org_name'] ?? 'My Lab'}'),
              address: Value('${manifest['address'] ?? ''}'),
              contact: Value('${manifest['contact'] ?? ''}'),
              email: Value('${manifest['email'] ?? ''}'),
              websiteUrl: Value('${manifest['website_url'] ?? ''}'),
              additionalInfo: Value('${manifest['additional_info'] ?? ''}'),
              logoPath: Value('${manifest['logo_path'] ?? ''}'),
              defaultDoctorCommissionPercent: Value(
                _intOrNull(manifest['default_doctor_commission_percent']) ?? 0,
              ),
              registered: Value(manifest['registered'] == true),
              securityEnabled: Value(manifest['security_enabled'] == true),
              passwordHash: Value(manifest['password_hash'] as String?),
              passwordSalt: Value(manifest['password_salt'] as String?),
              importPromptDone: Value(manifest['import_prompt_done'] != false),
              registeredAt: Value(_dt(manifest['registered_at'])),
              showReportHeader: Value(manifest['show_report_header'] != false),
              showReportFooter: Value(manifest['show_report_footer'] != false),
              showReportSectionTitles: Value(manifest['show_report_section_titles'] != false),
              reportFontPatientPt: Value(_intOrNull(manifest['report_font_patient_pt']) ?? 9),
              reportFontTestsPt: Value(_intOrNull(manifest['report_font_tests_pt']) ?? 9),
              reportFontDescriptionPt: Value(_intOrNull(manifest['report_font_description_pt']) ?? 8),
              reportColorInRange: Value(manifest['report_color_in_range'] != false),
              reportColorOutOfRange: Value(manifest['report_color_out_of_range'] != false),
              reportFlagLow: Value(manifest['report_flag_low'] != false),
              reportFlagHigh: Value(manifest['report_flag_high'] != false),
              reportHeaderHtml: Value(_manifestHtml(
                manifest['report_header_html'] ?? manifest['report_header_text'],
              )),
              reportFooterHtml: Value(_manifestHtml(
                manifest['report_footer_html'] ?? manifest['report_footer_text'],
              )),
              reportHeaderHeightMm: Value(_intOrNull(manifest['report_header_height_mm'])),
              reportFooterHeightMm: Value(_intOrNull(manifest['report_footer_height_mm'])),
            ),
          );

      for (final raw in doctors) {
        final d = Map<String, dynamic>.from(raw as Map);
        await db.into(db.doctors).insert(
              DoctorsCompanion.insert(
                id: Value(d['id'] as int),
                name: '${d['name'] ?? ''}',
                org: Value('${d['org'] ?? ''}'),
                email: Value('${d['email'] ?? ''}'),
                phone: Value('${d['phone'] ?? ''}'),
                address: Value('${d['address'] ?? ''}'),
                commissionPercent: Value(_num(d['commission'])),
                wallet: Value(_num(d['wallet'])),
                isInternal: Value(d['is_internal'] == true),
                deleteStatus: Value(d['delete_status'] == true),
                createdAt: Value(_dt(d['created_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in tests) {
        final t = Map<String, dynamic>.from(raw as Map);
        await db.into(db.labTests).insert(
              LabTestsCompanion.insert(
                id: Value(t['id'] as int),
                code: '${t['test_code'] ?? t['code'] ?? ''}',
                name: '${t['test_name'] ?? t['name'] ?? ''}',
                department: Value('${t['department'] ?? 'General'}'),
                description: Value('${t['description'] ?? ''}'),
                price: Value(_num(t['price'])),
                maxDisc: Value(_num(t['maxDisc'])),
                commissionPercent: Value(t['commission_percent'] == null ? null : _num(t['commission_percent'])),
                paramCount: Value((t['param_count'] as int?) ?? 1),
                masterTestId: Value(t['master_test_id'] as int?),
                deleteStatus: Value(t['delete_status'] == true),
                createdAt: Value(_dt(t['created_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in params) {
        final p = Map<String, dynamic>.from(raw as Map);
        await db.into(db.testParameters).insert(
              TestParametersCompanion.insert(
                id: Value(p['id'] as int),
                testId: (p['tests_id'] ?? p['test_id']) as int,
                title: '${p['title'] ?? ''}',
                unit: Value('${p['unit'] ?? ''}'),
                valueType: Value('${p['value_type'] ?? 'float'}'),
                formula: Value('${p['formula'] ?? ''}'),
                maleRange: Value('${p['male_range'] ?? ''}'),
                femaleRange: Value('${p['female_range'] ?? ''}'),
                sortOrder: Value((p['order'] as int?) ?? 0),
                sectionTitle: Value(p['section_title'] as String?),
                groupSumEquals: Value(
                  p['group_sum_equals'] == null ? null : _num(p['group_sum_equals']),
                ),
                masterParameterId: Value(p['master_parameter_id'] as int?),
                deleteStatus: Value(p['delete_status'] == true),
              ),
            );
      }

      for (final raw in patients) {
        final p = Map<String, dynamic>.from(raw as Map);
        final total = _num(p['total_amount']);
        final payable = _num(p['payable_amount']);
        await db.into(db.patients).insert(
              PatientsCompanion.insert(
                id: Value(p['id'] as int),
                prefix: Value('${p['pre_name'] ?? p['prefix'] ?? ''}'),
                firstName: '${p['first_name'] ?? p['firstName'] ?? ''}',
                lastName: Value('${p['second_name'] ?? p['lastName'] ?? ''}'),
                age: Value(p['age'] as int?),
                sex: Value('${p['gender'] ?? p['sex'] ?? ''}'),
                phone: Value('${p['mobile'] ?? p['phone'] ?? ''}'),
                email: Value('${p['email'] ?? ''}'),
                address: Value('${p['address'] ?? ''}'),
                doctorId: Value(p['reffered_by'] as int? ?? p['doctor_id'] as int?),
                referredBy: Value('${p['referred_by_text'] ?? ''}'),
                totalAmount: Value(total),
                discountAmount: Value(_num(p['Discount_amount'] ?? p['discount_amount'])),
                discountPercent: Value(_num(p['Discount_percent'] ?? p['discount_percent'])),
                payableAmount: Value(payable > 0 ? payable : total),
                paidAmount: Value(_num(p['paid_amount'])),
                paymentMethod: Value('${p['payment_method'] ?? ''}'),
                remark: Value('${p['remark'] ?? ''}'),
                status: Value('${p['workflow_status'] ?? p['status'] ?? 'Pending'}'),
                approvedAt: Value(_dt(p['approved_at'])),
                deleteStatus: Value(p['delete_status'] == true),
                createdAt: Value(_dt(p['created_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in patientTests) {
        final pt = Map<String, dynamic>.from(raw as Map);
        await db.into(db.patientTests).insert(
              PatientTestsCompanion.insert(
                id: Value(pt['id'] as int),
                patientId: pt['patient_id'] as int,
                testId: pt['test_id'] as int,
                price: Value(_num(pt['test_price'] ?? pt['price'])),
                deleteStatus: Value(pt['delete_status'] == true),
                createdAt: Value(_dt(pt['created_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in readings) {
        final r = Map<String, dynamic>.from(raw as Map);
        await db.into(db.testReadings).insert(
              TestReadingsCompanion.insert(
                id: Value(r['id'] as int),
                patientId: r['patient_id'] as int,
                patientTestId: Value(r['patient_test_id'] as int?),
                testParameterId: Value(r['test_parameter_id'] as int?),
                parameterName: '${r['parameter_name'] ?? ''}',
                value: Value('${r['reading'] ?? r['value'] ?? ''}'),
                unit: Value('${r['unit'] ?? ''}'),
                updatedAt: Value(_dt(r['updated_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in doctorPercents) {
        final s = Map<String, dynamic>.from(raw as Map);
        await db.into(db.doctorPercents).insert(
              DoctorPercentsCompanion.insert(
                id: Value(s['id'] as int),
                patientId: s['patient_id'] as int,
                doctorId: s['doctor_id'] as int,
                amount: Value(_num(s['amount'])),
                percent: Value(_num(s['percent'])),
                payableAmount: Value(_num(s['payable_amount'])),
                status: Value(s['status'] != false),
                deleteStatus: Value(s['delete_status'] == true),
                createdAt: Value(_dt(s['created_at']) ?? DateTime.now()),
              ),
            );
      }

      for (final raw in doctorCommissionItems) {
        final i = Map<String, dynamic>.from(raw as Map);
        await db.into(db.doctorCommissionItems).insert(
              DoctorCommissionItemsCompanion.insert(
                id: Value(i['id'] as int),
                doctorPercentId: i['doctor_percent_id'] as int,
                patientTestId: Value(i['patient_test_id'] as int?),
                testId: i['test_id'] as int,
                testName: Value('${i['test_name'] ?? ''}'),
                billedAmount: Value(_num(i['billed_amount'])),
                percentApplied: Value(_num(i['percent_applied'])),
                commissionAmount: Value(_num(i['commission_amount'])),
                status: Value(i['status'] != false),
                deleteStatus: Value(i['delete_status'] == true),
                createdAt: Value(_dt(i['created_at']) ?? DateTime.now()),
              ),
            );
      }
    });
  }

  static double _num(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse('$v') ?? 0;
  }

  static DateTime? _dt(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    return DateTime.tryParse('$v');
  }

  static int? _intOrNull(dynamic v) {
    if (v == null || v == '') return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v');
  }

  /// Keep HTML letterhead from web; only coerce to string.
  static String _manifestHtml(dynamic v) {
    if (v == null) return '';
    return '$v'.trim();
  }
}
