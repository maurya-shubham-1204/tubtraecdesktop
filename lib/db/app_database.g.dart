// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _labCodeMeta = const VerificationMeta(
    'labCode',
  );
  @override
  late final GeneratedColumn<String> labCode = GeneratedColumn<String>(
    'lab_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _licenseKeyMeta = const VerificationMeta(
    'licenseKey',
  );
  @override
  late final GeneratedColumn<String> licenseKey = GeneratedColumn<String>(
    'license_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _licenseVerMeta = const VerificationMeta(
    'licenseVer',
  );
  @override
  late final GeneratedColumn<String> licenseVer = GeneratedColumn<String>(
    'license_ver',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _labNameMeta = const VerificationMeta(
    'labName',
  );
  @override
  late final GeneratedColumn<String> labName = GeneratedColumn<String>(
    'lab_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('My Lab'),
  );
  static const VerificationMeta _registeredMeta = const VerificationMeta(
    'registered',
  );
  @override
  late final GeneratedColumn<bool> registered = GeneratedColumn<bool>(
    'registered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("registered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _securityEnabledMeta = const VerificationMeta(
    'securityEnabled',
  );
  @override
  late final GeneratedColumn<bool> securityEnabled = GeneratedColumn<bool>(
    'security_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("security_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importPromptDoneMeta = const VerificationMeta(
    'importPromptDone',
  );
  @override
  late final GeneratedColumn<bool> importPromptDone = GeneratedColumn<bool>(
    'import_prompt_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("import_prompt_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _registeredAtMeta = const VerificationMeta(
    'registeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> registeredAt = GeneratedColumn<DateTime>(
    'registered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _showReportHeaderMeta = const VerificationMeta(
    'showReportHeader',
  );
  @override
  late final GeneratedColumn<bool> showReportHeader = GeneratedColumn<bool>(
    'show_report_header',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_report_header" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showReportFooterMeta = const VerificationMeta(
    'showReportFooter',
  );
  @override
  late final GeneratedColumn<bool> showReportFooter = GeneratedColumn<bool>(
    'show_report_footer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_report_footer" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reportHeaderHtmlMeta = const VerificationMeta(
    'reportHeaderHtml',
  );
  @override
  late final GeneratedColumn<String> reportHeaderHtml = GeneratedColumn<String>(
    'report_header_html',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _reportFooterHtmlMeta = const VerificationMeta(
    'reportFooterHtml',
  );
  @override
  late final GeneratedColumn<String> reportFooterHtml = GeneratedColumn<String>(
    'report_footer_html',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _reportHeaderHeightMmMeta =
      const VerificationMeta('reportHeaderHeightMm');
  @override
  late final GeneratedColumn<int> reportHeaderHeightMm = GeneratedColumn<int>(
    'report_header_height_mm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportFooterHeightMmMeta =
      const VerificationMeta('reportFooterHeightMm');
  @override
  late final GeneratedColumn<int> reportFooterHeightMm = GeneratedColumn<int>(
    'report_footer_height_mm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    labCode,
    licenseKey,
    licenseVer,
    labName,
    registered,
    securityEnabled,
    passwordHash,
    passwordSalt,
    importPromptDone,
    registeredAt,
    showReportHeader,
    showReportFooter,
    reportHeaderHtml,
    reportFooterHtml,
    reportHeaderHeightMm,
    reportFooterHeightMm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lab_code')) {
      context.handle(
        _labCodeMeta,
        labCode.isAcceptableOrUnknown(data['lab_code']!, _labCodeMeta),
      );
    }
    if (data.containsKey('license_key')) {
      context.handle(
        _licenseKeyMeta,
        licenseKey.isAcceptableOrUnknown(data['license_key']!, _licenseKeyMeta),
      );
    }
    if (data.containsKey('license_ver')) {
      context.handle(
        _licenseVerMeta,
        licenseVer.isAcceptableOrUnknown(data['license_ver']!, _licenseVerMeta),
      );
    }
    if (data.containsKey('lab_name')) {
      context.handle(
        _labNameMeta,
        labName.isAcceptableOrUnknown(data['lab_name']!, _labNameMeta),
      );
    }
    if (data.containsKey('registered')) {
      context.handle(
        _registeredMeta,
        registered.isAcceptableOrUnknown(data['registered']!, _registeredMeta),
      );
    }
    if (data.containsKey('security_enabled')) {
      context.handle(
        _securityEnabledMeta,
        securityEnabled.isAcceptableOrUnknown(
          data['security_enabled']!,
          _securityEnabledMeta,
        ),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    }
    if (data.containsKey('import_prompt_done')) {
      context.handle(
        _importPromptDoneMeta,
        importPromptDone.isAcceptableOrUnknown(
          data['import_prompt_done']!,
          _importPromptDoneMeta,
        ),
      );
    }
    if (data.containsKey('registered_at')) {
      context.handle(
        _registeredAtMeta,
        registeredAt.isAcceptableOrUnknown(
          data['registered_at']!,
          _registeredAtMeta,
        ),
      );
    }
    if (data.containsKey('show_report_header')) {
      context.handle(
        _showReportHeaderMeta,
        showReportHeader.isAcceptableOrUnknown(
          data['show_report_header']!,
          _showReportHeaderMeta,
        ),
      );
    }
    if (data.containsKey('show_report_footer')) {
      context.handle(
        _showReportFooterMeta,
        showReportFooter.isAcceptableOrUnknown(
          data['show_report_footer']!,
          _showReportFooterMeta,
        ),
      );
    }
    if (data.containsKey('report_header_html')) {
      context.handle(
        _reportHeaderHtmlMeta,
        reportHeaderHtml.isAcceptableOrUnknown(
          data['report_header_html']!,
          _reportHeaderHtmlMeta,
        ),
      );
    }
    if (data.containsKey('report_footer_html')) {
      context.handle(
        _reportFooterHtmlMeta,
        reportFooterHtml.isAcceptableOrUnknown(
          data['report_footer_html']!,
          _reportFooterHtmlMeta,
        ),
      );
    }
    if (data.containsKey('report_header_height_mm')) {
      context.handle(
        _reportHeaderHeightMmMeta,
        reportHeaderHeightMm.isAcceptableOrUnknown(
          data['report_header_height_mm']!,
          _reportHeaderHeightMmMeta,
        ),
      );
    }
    if (data.containsKey('report_footer_height_mm')) {
      context.handle(
        _reportFooterHeightMmMeta,
        reportFooterHeightMm.isAcceptableOrUnknown(
          data['report_footer_height_mm']!,
          _reportFooterHeightMmMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      labCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_code'],
      )!,
      licenseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_key'],
      )!,
      licenseVer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_ver'],
      )!,
      labName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_name'],
      )!,
      registered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}registered'],
      )!,
      securityEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}security_enabled'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      ),
      importPromptDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}import_prompt_done'],
      )!,
      registeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registered_at'],
      ),
      showReportHeader: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_report_header'],
      )!,
      showReportFooter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_report_footer'],
      )!,
      reportHeaderHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_header_html'],
      )!,
      reportFooterHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_footer_html'],
      )!,
      reportHeaderHeightMm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_header_height_mm'],
      ),
      reportFooterHeightMm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_footer_height_mm'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String labCode;
  final String licenseKey;
  final String licenseVer;
  final String labName;
  final bool registered;
  final bool securityEnabled;
  final String? passwordHash;
  final String? passwordSalt;
  final bool importPromptDone;
  final DateTime? registeredAt;

  /// Match web lab_settings.show_report_header / show_report_footer.
  final bool showReportHeader;
  final bool showReportFooter;

  /// Web `report_header_html` / `report_footer_html` (HTML letterhead).
  final String reportHeaderHtml;
  final String reportFooterHtml;
  final int? reportHeaderHeightMm;
  final int? reportFooterHeightMm;
  const AppSetting({
    required this.id,
    required this.labCode,
    required this.licenseKey,
    required this.licenseVer,
    required this.labName,
    required this.registered,
    required this.securityEnabled,
    this.passwordHash,
    this.passwordSalt,
    required this.importPromptDone,
    this.registeredAt,
    required this.showReportHeader,
    required this.showReportFooter,
    required this.reportHeaderHtml,
    required this.reportFooterHtml,
    this.reportHeaderHeightMm,
    this.reportFooterHeightMm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lab_code'] = Variable<String>(labCode);
    map['license_key'] = Variable<String>(licenseKey);
    map['license_ver'] = Variable<String>(licenseVer);
    map['lab_name'] = Variable<String>(labName);
    map['registered'] = Variable<bool>(registered);
    map['security_enabled'] = Variable<bool>(securityEnabled);
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    if (!nullToAbsent || passwordSalt != null) {
      map['password_salt'] = Variable<String>(passwordSalt);
    }
    map['import_prompt_done'] = Variable<bool>(importPromptDone);
    if (!nullToAbsent || registeredAt != null) {
      map['registered_at'] = Variable<DateTime>(registeredAt);
    }
    map['show_report_header'] = Variable<bool>(showReportHeader);
    map['show_report_footer'] = Variable<bool>(showReportFooter);
    map['report_header_html'] = Variable<String>(reportHeaderHtml);
    map['report_footer_html'] = Variable<String>(reportFooterHtml);
    if (!nullToAbsent || reportHeaderHeightMm != null) {
      map['report_header_height_mm'] = Variable<int>(reportHeaderHeightMm);
    }
    if (!nullToAbsent || reportFooterHeightMm != null) {
      map['report_footer_height_mm'] = Variable<int>(reportFooterHeightMm);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      labCode: Value(labCode),
      licenseKey: Value(licenseKey),
      licenseVer: Value(licenseVer),
      labName: Value(labName),
      registered: Value(registered),
      securityEnabled: Value(securityEnabled),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      passwordSalt: passwordSalt == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordSalt),
      importPromptDone: Value(importPromptDone),
      registeredAt: registeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(registeredAt),
      showReportHeader: Value(showReportHeader),
      showReportFooter: Value(showReportFooter),
      reportHeaderHtml: Value(reportHeaderHtml),
      reportFooterHtml: Value(reportFooterHtml),
      reportHeaderHeightMm: reportHeaderHeightMm == null && nullToAbsent
          ? const Value.absent()
          : Value(reportHeaderHeightMm),
      reportFooterHeightMm: reportFooterHeightMm == null && nullToAbsent
          ? const Value.absent()
          : Value(reportFooterHeightMm),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      labCode: serializer.fromJson<String>(json['labCode']),
      licenseKey: serializer.fromJson<String>(json['licenseKey']),
      licenseVer: serializer.fromJson<String>(json['licenseVer']),
      labName: serializer.fromJson<String>(json['labName']),
      registered: serializer.fromJson<bool>(json['registered']),
      securityEnabled: serializer.fromJson<bool>(json['securityEnabled']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String?>(json['passwordSalt']),
      importPromptDone: serializer.fromJson<bool>(json['importPromptDone']),
      registeredAt: serializer.fromJson<DateTime?>(json['registeredAt']),
      showReportHeader: serializer.fromJson<bool>(json['showReportHeader']),
      showReportFooter: serializer.fromJson<bool>(json['showReportFooter']),
      reportHeaderHtml: serializer.fromJson<String>(json['reportHeaderHtml']),
      reportFooterHtml: serializer.fromJson<String>(json['reportFooterHtml']),
      reportHeaderHeightMm: serializer.fromJson<int?>(
        json['reportHeaderHeightMm'],
      ),
      reportFooterHeightMm: serializer.fromJson<int?>(
        json['reportFooterHeightMm'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'labCode': serializer.toJson<String>(labCode),
      'licenseKey': serializer.toJson<String>(licenseKey),
      'licenseVer': serializer.toJson<String>(licenseVer),
      'labName': serializer.toJson<String>(labName),
      'registered': serializer.toJson<bool>(registered),
      'securityEnabled': serializer.toJson<bool>(securityEnabled),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'passwordSalt': serializer.toJson<String?>(passwordSalt),
      'importPromptDone': serializer.toJson<bool>(importPromptDone),
      'registeredAt': serializer.toJson<DateTime?>(registeredAt),
      'showReportHeader': serializer.toJson<bool>(showReportHeader),
      'showReportFooter': serializer.toJson<bool>(showReportFooter),
      'reportHeaderHtml': serializer.toJson<String>(reportHeaderHtml),
      'reportFooterHtml': serializer.toJson<String>(reportFooterHtml),
      'reportHeaderHeightMm': serializer.toJson<int?>(reportHeaderHeightMm),
      'reportFooterHeightMm': serializer.toJson<int?>(reportFooterHeightMm),
    };
  }

  AppSetting copyWith({
    int? id,
    String? labCode,
    String? licenseKey,
    String? licenseVer,
    String? labName,
    bool? registered,
    bool? securityEnabled,
    Value<String?> passwordHash = const Value.absent(),
    Value<String?> passwordSalt = const Value.absent(),
    bool? importPromptDone,
    Value<DateTime?> registeredAt = const Value.absent(),
    bool? showReportHeader,
    bool? showReportFooter,
    String? reportHeaderHtml,
    String? reportFooterHtml,
    Value<int?> reportHeaderHeightMm = const Value.absent(),
    Value<int?> reportFooterHeightMm = const Value.absent(),
  }) => AppSetting(
    id: id ?? this.id,
    labCode: labCode ?? this.labCode,
    licenseKey: licenseKey ?? this.licenseKey,
    licenseVer: licenseVer ?? this.licenseVer,
    labName: labName ?? this.labName,
    registered: registered ?? this.registered,
    securityEnabled: securityEnabled ?? this.securityEnabled,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    passwordSalt: passwordSalt.present ? passwordSalt.value : this.passwordSalt,
    importPromptDone: importPromptDone ?? this.importPromptDone,
    registeredAt: registeredAt.present ? registeredAt.value : this.registeredAt,
    showReportHeader: showReportHeader ?? this.showReportHeader,
    showReportFooter: showReportFooter ?? this.showReportFooter,
    reportHeaderHtml: reportHeaderHtml ?? this.reportHeaderHtml,
    reportFooterHtml: reportFooterHtml ?? this.reportFooterHtml,
    reportHeaderHeightMm: reportHeaderHeightMm.present
        ? reportHeaderHeightMm.value
        : this.reportHeaderHeightMm,
    reportFooterHeightMm: reportFooterHeightMm.present
        ? reportFooterHeightMm.value
        : this.reportFooterHeightMm,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      labCode: data.labCode.present ? data.labCode.value : this.labCode,
      licenseKey: data.licenseKey.present
          ? data.licenseKey.value
          : this.licenseKey,
      licenseVer: data.licenseVer.present
          ? data.licenseVer.value
          : this.licenseVer,
      labName: data.labName.present ? data.labName.value : this.labName,
      registered: data.registered.present
          ? data.registered.value
          : this.registered,
      securityEnabled: data.securityEnabled.present
          ? data.securityEnabled.value
          : this.securityEnabled,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      importPromptDone: data.importPromptDone.present
          ? data.importPromptDone.value
          : this.importPromptDone,
      registeredAt: data.registeredAt.present
          ? data.registeredAt.value
          : this.registeredAt,
      showReportHeader: data.showReportHeader.present
          ? data.showReportHeader.value
          : this.showReportHeader,
      showReportFooter: data.showReportFooter.present
          ? data.showReportFooter.value
          : this.showReportFooter,
      reportHeaderHtml: data.reportHeaderHtml.present
          ? data.reportHeaderHtml.value
          : this.reportHeaderHtml,
      reportFooterHtml: data.reportFooterHtml.present
          ? data.reportFooterHtml.value
          : this.reportFooterHtml,
      reportHeaderHeightMm: data.reportHeaderHeightMm.present
          ? data.reportHeaderHeightMm.value
          : this.reportHeaderHeightMm,
      reportFooterHeightMm: data.reportFooterHeightMm.present
          ? data.reportFooterHeightMm.value
          : this.reportFooterHeightMm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('labCode: $labCode, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('licenseVer: $licenseVer, ')
          ..write('labName: $labName, ')
          ..write('registered: $registered, ')
          ..write('securityEnabled: $securityEnabled, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('importPromptDone: $importPromptDone, ')
          ..write('registeredAt: $registeredAt, ')
          ..write('showReportHeader: $showReportHeader, ')
          ..write('showReportFooter: $showReportFooter, ')
          ..write('reportHeaderHtml: $reportHeaderHtml, ')
          ..write('reportFooterHtml: $reportFooterHtml, ')
          ..write('reportHeaderHeightMm: $reportHeaderHeightMm, ')
          ..write('reportFooterHeightMm: $reportFooterHeightMm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    labCode,
    licenseKey,
    licenseVer,
    labName,
    registered,
    securityEnabled,
    passwordHash,
    passwordSalt,
    importPromptDone,
    registeredAt,
    showReportHeader,
    showReportFooter,
    reportHeaderHtml,
    reportFooterHtml,
    reportHeaderHeightMm,
    reportFooterHeightMm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.labCode == this.labCode &&
          other.licenseKey == this.licenseKey &&
          other.licenseVer == this.licenseVer &&
          other.labName == this.labName &&
          other.registered == this.registered &&
          other.securityEnabled == this.securityEnabled &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.importPromptDone == this.importPromptDone &&
          other.registeredAt == this.registeredAt &&
          other.showReportHeader == this.showReportHeader &&
          other.showReportFooter == this.showReportFooter &&
          other.reportHeaderHtml == this.reportHeaderHtml &&
          other.reportFooterHtml == this.reportFooterHtml &&
          other.reportHeaderHeightMm == this.reportHeaderHeightMm &&
          other.reportFooterHeightMm == this.reportFooterHeightMm);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> labCode;
  final Value<String> licenseKey;
  final Value<String> licenseVer;
  final Value<String> labName;
  final Value<bool> registered;
  final Value<bool> securityEnabled;
  final Value<String?> passwordHash;
  final Value<String?> passwordSalt;
  final Value<bool> importPromptDone;
  final Value<DateTime?> registeredAt;
  final Value<bool> showReportHeader;
  final Value<bool> showReportFooter;
  final Value<String> reportHeaderHtml;
  final Value<String> reportFooterHtml;
  final Value<int?> reportHeaderHeightMm;
  final Value<int?> reportFooterHeightMm;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.labCode = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.licenseVer = const Value.absent(),
    this.labName = const Value.absent(),
    this.registered = const Value.absent(),
    this.securityEnabled = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.importPromptDone = const Value.absent(),
    this.registeredAt = const Value.absent(),
    this.showReportHeader = const Value.absent(),
    this.showReportFooter = const Value.absent(),
    this.reportHeaderHtml = const Value.absent(),
    this.reportFooterHtml = const Value.absent(),
    this.reportHeaderHeightMm = const Value.absent(),
    this.reportFooterHeightMm = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.labCode = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.licenseVer = const Value.absent(),
    this.labName = const Value.absent(),
    this.registered = const Value.absent(),
    this.securityEnabled = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.importPromptDone = const Value.absent(),
    this.registeredAt = const Value.absent(),
    this.showReportHeader = const Value.absent(),
    this.showReportFooter = const Value.absent(),
    this.reportHeaderHtml = const Value.absent(),
    this.reportFooterHtml = const Value.absent(),
    this.reportHeaderHeightMm = const Value.absent(),
    this.reportFooterHeightMm = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? labCode,
    Expression<String>? licenseKey,
    Expression<String>? licenseVer,
    Expression<String>? labName,
    Expression<bool>? registered,
    Expression<bool>? securityEnabled,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<bool>? importPromptDone,
    Expression<DateTime>? registeredAt,
    Expression<bool>? showReportHeader,
    Expression<bool>? showReportFooter,
    Expression<String>? reportHeaderHtml,
    Expression<String>? reportFooterHtml,
    Expression<int>? reportHeaderHeightMm,
    Expression<int>? reportFooterHeightMm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (labCode != null) 'lab_code': labCode,
      if (licenseKey != null) 'license_key': licenseKey,
      if (licenseVer != null) 'license_ver': licenseVer,
      if (labName != null) 'lab_name': labName,
      if (registered != null) 'registered': registered,
      if (securityEnabled != null) 'security_enabled': securityEnabled,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (importPromptDone != null) 'import_prompt_done': importPromptDone,
      if (registeredAt != null) 'registered_at': registeredAt,
      if (showReportHeader != null) 'show_report_header': showReportHeader,
      if (showReportFooter != null) 'show_report_footer': showReportFooter,
      if (reportHeaderHtml != null) 'report_header_html': reportHeaderHtml,
      if (reportFooterHtml != null) 'report_footer_html': reportFooterHtml,
      if (reportHeaderHeightMm != null)
        'report_header_height_mm': reportHeaderHeightMm,
      if (reportFooterHeightMm != null)
        'report_footer_height_mm': reportFooterHeightMm,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? labCode,
    Value<String>? licenseKey,
    Value<String>? licenseVer,
    Value<String>? labName,
    Value<bool>? registered,
    Value<bool>? securityEnabled,
    Value<String?>? passwordHash,
    Value<String?>? passwordSalt,
    Value<bool>? importPromptDone,
    Value<DateTime?>? registeredAt,
    Value<bool>? showReportHeader,
    Value<bool>? showReportFooter,
    Value<String>? reportHeaderHtml,
    Value<String>? reportFooterHtml,
    Value<int?>? reportHeaderHeightMm,
    Value<int?>? reportFooterHeightMm,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      labCode: labCode ?? this.labCode,
      licenseKey: licenseKey ?? this.licenseKey,
      licenseVer: licenseVer ?? this.licenseVer,
      labName: labName ?? this.labName,
      registered: registered ?? this.registered,
      securityEnabled: securityEnabled ?? this.securityEnabled,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      importPromptDone: importPromptDone ?? this.importPromptDone,
      registeredAt: registeredAt ?? this.registeredAt,
      showReportHeader: showReportHeader ?? this.showReportHeader,
      showReportFooter: showReportFooter ?? this.showReportFooter,
      reportHeaderHtml: reportHeaderHtml ?? this.reportHeaderHtml,
      reportFooterHtml: reportFooterHtml ?? this.reportFooterHtml,
      reportHeaderHeightMm: reportHeaderHeightMm ?? this.reportHeaderHeightMm,
      reportFooterHeightMm: reportFooterHeightMm ?? this.reportFooterHeightMm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (labCode.present) {
      map['lab_code'] = Variable<String>(labCode.value);
    }
    if (licenseKey.present) {
      map['license_key'] = Variable<String>(licenseKey.value);
    }
    if (licenseVer.present) {
      map['license_ver'] = Variable<String>(licenseVer.value);
    }
    if (labName.present) {
      map['lab_name'] = Variable<String>(labName.value);
    }
    if (registered.present) {
      map['registered'] = Variable<bool>(registered.value);
    }
    if (securityEnabled.present) {
      map['security_enabled'] = Variable<bool>(securityEnabled.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (importPromptDone.present) {
      map['import_prompt_done'] = Variable<bool>(importPromptDone.value);
    }
    if (registeredAt.present) {
      map['registered_at'] = Variable<DateTime>(registeredAt.value);
    }
    if (showReportHeader.present) {
      map['show_report_header'] = Variable<bool>(showReportHeader.value);
    }
    if (showReportFooter.present) {
      map['show_report_footer'] = Variable<bool>(showReportFooter.value);
    }
    if (reportHeaderHtml.present) {
      map['report_header_html'] = Variable<String>(reportHeaderHtml.value);
    }
    if (reportFooterHtml.present) {
      map['report_footer_html'] = Variable<String>(reportFooterHtml.value);
    }
    if (reportHeaderHeightMm.present) {
      map['report_header_height_mm'] = Variable<int>(
        reportHeaderHeightMm.value,
      );
    }
    if (reportFooterHeightMm.present) {
      map['report_footer_height_mm'] = Variable<int>(
        reportFooterHeightMm.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('labCode: $labCode, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('licenseVer: $licenseVer, ')
          ..write('labName: $labName, ')
          ..write('registered: $registered, ')
          ..write('securityEnabled: $securityEnabled, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('importPromptDone: $importPromptDone, ')
          ..write('registeredAt: $registeredAt, ')
          ..write('showReportHeader: $showReportHeader, ')
          ..write('showReportFooter: $showReportFooter, ')
          ..write('reportHeaderHtml: $reportHeaderHtml, ')
          ..write('reportFooterHtml: $reportFooterHtml, ')
          ..write('reportHeaderHeightMm: $reportHeaderHeightMm, ')
          ..write('reportFooterHeightMm: $reportFooterHeightMm')
          ..write(')'))
        .toString();
  }
}

class $DoctorsTable extends Doctors with TableInfo<$DoctorsTable, Doctor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orgMeta = const VerificationMeta('org');
  @override
  late final GeneratedColumn<String> org = GeneratedColumn<String>(
    'org',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _commissionPercentMeta = const VerificationMeta(
    'commissionPercent',
  );
  @override
  late final GeneratedColumn<double> commissionPercent =
      GeneratedColumn<double>(
        'commission_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _walletMeta = const VerificationMeta('wallet');
  @override
  late final GeneratedColumn<double> wallet = GeneratedColumn<double>(
    'wallet',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isInternalMeta = const VerificationMeta(
    'isInternal',
  );
  @override
  late final GeneratedColumn<bool> isInternal = GeneratedColumn<bool>(
    'is_internal',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_internal" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _deleteStatusMeta = const VerificationMeta(
    'deleteStatus',
  );
  @override
  late final GeneratedColumn<bool> deleteStatus = GeneratedColumn<bool>(
    'delete_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    org,
    email,
    phone,
    address,
    commissionPercent,
    wallet,
    isInternal,
    deleteStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Doctor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('org')) {
      context.handle(
        _orgMeta,
        org.isAcceptableOrUnknown(data['org']!, _orgMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('commission_percent')) {
      context.handle(
        _commissionPercentMeta,
        commissionPercent.isAcceptableOrUnknown(
          data['commission_percent']!,
          _commissionPercentMeta,
        ),
      );
    }
    if (data.containsKey('wallet')) {
      context.handle(
        _walletMeta,
        wallet.isAcceptableOrUnknown(data['wallet']!, _walletMeta),
      );
    }
    if (data.containsKey('is_internal')) {
      context.handle(
        _isInternalMeta,
        isInternal.isAcceptableOrUnknown(data['is_internal']!, _isInternalMeta),
      );
    }
    if (data.containsKey('delete_status')) {
      context.handle(
        _deleteStatusMeta,
        deleteStatus.isAcceptableOrUnknown(
          data['delete_status']!,
          _deleteStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Doctor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Doctor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      org: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}org'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      commissionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent'],
      )!,
      wallet: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wallet'],
      )!,
      isInternal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_internal'],
      )!,
      deleteStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DoctorsTable createAlias(String alias) {
    return $DoctorsTable(attachedDatabase, alias);
  }
}

class Doctor extends DataClass implements Insertable<Doctor> {
  final int id;
  final String name;
  final String org;
  final String email;
  final String phone;
  final String address;
  final double commissionPercent;
  final double wallet;
  final bool isInternal;
  final bool deleteStatus;
  final DateTime createdAt;
  const Doctor({
    required this.id,
    required this.name,
    required this.org,
    required this.email,
    required this.phone,
    required this.address,
    required this.commissionPercent,
    required this.wallet,
    required this.isInternal,
    required this.deleteStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['org'] = Variable<String>(org);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['commission_percent'] = Variable<double>(commissionPercent);
    map['wallet'] = Variable<double>(wallet);
    map['is_internal'] = Variable<bool>(isInternal);
    map['delete_status'] = Variable<bool>(deleteStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DoctorsCompanion toCompanion(bool nullToAbsent) {
    return DoctorsCompanion(
      id: Value(id),
      name: Value(name),
      org: Value(org),
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      commissionPercent: Value(commissionPercent),
      wallet: Value(wallet),
      isInternal: Value(isInternal),
      deleteStatus: Value(deleteStatus),
      createdAt: Value(createdAt),
    );
  }

  factory Doctor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Doctor(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      org: serializer.fromJson<String>(json['org']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      commissionPercent: serializer.fromJson<double>(json['commissionPercent']),
      wallet: serializer.fromJson<double>(json['wallet']),
      isInternal: serializer.fromJson<bool>(json['isInternal']),
      deleteStatus: serializer.fromJson<bool>(json['deleteStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'org': serializer.toJson<String>(org),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'commissionPercent': serializer.toJson<double>(commissionPercent),
      'wallet': serializer.toJson<double>(wallet),
      'isInternal': serializer.toJson<bool>(isInternal),
      'deleteStatus': serializer.toJson<bool>(deleteStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Doctor copyWith({
    int? id,
    String? name,
    String? org,
    String? email,
    String? phone,
    String? address,
    double? commissionPercent,
    double? wallet,
    bool? isInternal,
    bool? deleteStatus,
    DateTime? createdAt,
  }) => Doctor(
    id: id ?? this.id,
    name: name ?? this.name,
    org: org ?? this.org,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    commissionPercent: commissionPercent ?? this.commissionPercent,
    wallet: wallet ?? this.wallet,
    isInternal: isInternal ?? this.isInternal,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  Doctor copyWithCompanion(DoctorsCompanion data) {
    return Doctor(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      org: data.org.present ? data.org.value : this.org,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      commissionPercent: data.commissionPercent.present
          ? data.commissionPercent.value
          : this.commissionPercent,
      wallet: data.wallet.present ? data.wallet.value : this.wallet,
      isInternal: data.isInternal.present
          ? data.isInternal.value
          : this.isInternal,
      deleteStatus: data.deleteStatus.present
          ? data.deleteStatus.value
          : this.deleteStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Doctor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('org: $org, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('wallet: $wallet, ')
          ..write('isInternal: $isInternal, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    org,
    email,
    phone,
    address,
    commissionPercent,
    wallet,
    isInternal,
    deleteStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Doctor &&
          other.id == this.id &&
          other.name == this.name &&
          other.org == this.org &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.commissionPercent == this.commissionPercent &&
          other.wallet == this.wallet &&
          other.isInternal == this.isInternal &&
          other.deleteStatus == this.deleteStatus &&
          other.createdAt == this.createdAt);
}

class DoctorsCompanion extends UpdateCompanion<Doctor> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> org;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> address;
  final Value<double> commissionPercent;
  final Value<double> wallet;
  final Value<bool> isInternal;
  final Value<bool> deleteStatus;
  final Value<DateTime> createdAt;
  const DoctorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.org = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.wallet = const Value.absent(),
    this.isInternal = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DoctorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.org = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.wallet = const Value.absent(),
    this.isInternal = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Doctor> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? org,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<double>? commissionPercent,
    Expression<double>? wallet,
    Expression<bool>? isInternal,
    Expression<bool>? deleteStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (org != null) 'org': org,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (commissionPercent != null) 'commission_percent': commissionPercent,
      if (wallet != null) 'wallet': wallet,
      if (isInternal != null) 'is_internal': isInternal,
      if (deleteStatus != null) 'delete_status': deleteStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DoctorsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? org,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? address,
    Value<double>? commissionPercent,
    Value<double>? wallet,
    Value<bool>? isInternal,
    Value<bool>? deleteStatus,
    Value<DateTime>? createdAt,
  }) {
    return DoctorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      org: org ?? this.org,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      commissionPercent: commissionPercent ?? this.commissionPercent,
      wallet: wallet ?? this.wallet,
      isInternal: isInternal ?? this.isInternal,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (org.present) {
      map['org'] = Variable<String>(org.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (commissionPercent.present) {
      map['commission_percent'] = Variable<double>(commissionPercent.value);
    }
    if (wallet.present) {
      map['wallet'] = Variable<double>(wallet.value);
    }
    if (isInternal.present) {
      map['is_internal'] = Variable<bool>(isInternal.value);
    }
    if (deleteStatus.present) {
      map['delete_status'] = Variable<bool>(deleteStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('org: $org, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('wallet: $wallet, ')
          ..write('isInternal: $isInternal, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LabTestsTable extends LabTests with TableInfo<$LabTestsTable, LabTest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabTestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('General'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxDiscMeta = const VerificationMeta(
    'maxDisc',
  );
  @override
  late final GeneratedColumn<double> maxDisc = GeneratedColumn<double>(
    'max_disc',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _commissionPercentMeta = const VerificationMeta(
    'commissionPercent',
  );
  @override
  late final GeneratedColumn<double> commissionPercent =
      GeneratedColumn<double>(
        'commission_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _paramCountMeta = const VerificationMeta(
    'paramCount',
  );
  @override
  late final GeneratedColumn<int> paramCount = GeneratedColumn<int>(
    'param_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _masterTestIdMeta = const VerificationMeta(
    'masterTestId',
  );
  @override
  late final GeneratedColumn<int> masterTestId = GeneratedColumn<int>(
    'master_test_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deleteStatusMeta = const VerificationMeta(
    'deleteStatus',
  );
  @override
  late final GeneratedColumn<bool> deleteStatus = GeneratedColumn<bool>(
    'delete_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    department,
    description,
    price,
    maxDisc,
    commissionPercent,
    paramCount,
    masterTestId,
    deleteStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabTest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('max_disc')) {
      context.handle(
        _maxDiscMeta,
        maxDisc.isAcceptableOrUnknown(data['max_disc']!, _maxDiscMeta),
      );
    }
    if (data.containsKey('commission_percent')) {
      context.handle(
        _commissionPercentMeta,
        commissionPercent.isAcceptableOrUnknown(
          data['commission_percent']!,
          _commissionPercentMeta,
        ),
      );
    }
    if (data.containsKey('param_count')) {
      context.handle(
        _paramCountMeta,
        paramCount.isAcceptableOrUnknown(data['param_count']!, _paramCountMeta),
      );
    }
    if (data.containsKey('master_test_id')) {
      context.handle(
        _masterTestIdMeta,
        masterTestId.isAcceptableOrUnknown(
          data['master_test_id']!,
          _masterTestIdMeta,
        ),
      );
    }
    if (data.containsKey('delete_status')) {
      context.handle(
        _deleteStatusMeta,
        deleteStatus.isAcceptableOrUnknown(
          data['delete_status']!,
          _deleteStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabTest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabTest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      maxDisc: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_disc'],
      )!,
      commissionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent'],
      ),
      paramCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}param_count'],
      )!,
      masterTestId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}master_test_id'],
      ),
      deleteStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LabTestsTable createAlias(String alias) {
    return $LabTestsTable(attachedDatabase, alias);
  }
}

class LabTest extends DataClass implements Insertable<LabTest> {
  final int id;
  final String code;
  final String name;
  final String department;
  final String description;
  final double price;
  final double maxDisc;
  final double? commissionPercent;
  final int paramCount;
  final int? masterTestId;
  final bool deleteStatus;
  final DateTime createdAt;
  const LabTest({
    required this.id,
    required this.code,
    required this.name,
    required this.department,
    required this.description,
    required this.price,
    required this.maxDisc,
    this.commissionPercent,
    required this.paramCount,
    this.masterTestId,
    required this.deleteStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['department'] = Variable<String>(department);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    map['max_disc'] = Variable<double>(maxDisc);
    if (!nullToAbsent || commissionPercent != null) {
      map['commission_percent'] = Variable<double>(commissionPercent);
    }
    map['param_count'] = Variable<int>(paramCount);
    if (!nullToAbsent || masterTestId != null) {
      map['master_test_id'] = Variable<int>(masterTestId);
    }
    map['delete_status'] = Variable<bool>(deleteStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabTestsCompanion toCompanion(bool nullToAbsent) {
    return LabTestsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      department: Value(department),
      description: Value(description),
      price: Value(price),
      maxDisc: Value(maxDisc),
      commissionPercent: commissionPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(commissionPercent),
      paramCount: Value(paramCount),
      masterTestId: masterTestId == null && nullToAbsent
          ? const Value.absent()
          : Value(masterTestId),
      deleteStatus: Value(deleteStatus),
      createdAt: Value(createdAt),
    );
  }

  factory LabTest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabTest(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      department: serializer.fromJson<String>(json['department']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      maxDisc: serializer.fromJson<double>(json['maxDisc']),
      commissionPercent: serializer.fromJson<double?>(
        json['commissionPercent'],
      ),
      paramCount: serializer.fromJson<int>(json['paramCount']),
      masterTestId: serializer.fromJson<int?>(json['masterTestId']),
      deleteStatus: serializer.fromJson<bool>(json['deleteStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'department': serializer.toJson<String>(department),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'maxDisc': serializer.toJson<double>(maxDisc),
      'commissionPercent': serializer.toJson<double?>(commissionPercent),
      'paramCount': serializer.toJson<int>(paramCount),
      'masterTestId': serializer.toJson<int?>(masterTestId),
      'deleteStatus': serializer.toJson<bool>(deleteStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabTest copyWith({
    int? id,
    String? code,
    String? name,
    String? department,
    String? description,
    double? price,
    double? maxDisc,
    Value<double?> commissionPercent = const Value.absent(),
    int? paramCount,
    Value<int?> masterTestId = const Value.absent(),
    bool? deleteStatus,
    DateTime? createdAt,
  }) => LabTest(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    department: department ?? this.department,
    description: description ?? this.description,
    price: price ?? this.price,
    maxDisc: maxDisc ?? this.maxDisc,
    commissionPercent: commissionPercent.present
        ? commissionPercent.value
        : this.commissionPercent,
    paramCount: paramCount ?? this.paramCount,
    masterTestId: masterTestId.present ? masterTestId.value : this.masterTestId,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  LabTest copyWithCompanion(LabTestsCompanion data) {
    return LabTest(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      department: data.department.present
          ? data.department.value
          : this.department,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      maxDisc: data.maxDisc.present ? data.maxDisc.value : this.maxDisc,
      commissionPercent: data.commissionPercent.present
          ? data.commissionPercent.value
          : this.commissionPercent,
      paramCount: data.paramCount.present
          ? data.paramCount.value
          : this.paramCount,
      masterTestId: data.masterTestId.present
          ? data.masterTestId.value
          : this.masterTestId,
      deleteStatus: data.deleteStatus.present
          ? data.deleteStatus.value
          : this.deleteStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabTest(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('department: $department, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('maxDisc: $maxDisc, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('paramCount: $paramCount, ')
          ..write('masterTestId: $masterTestId, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    department,
    description,
    price,
    maxDisc,
    commissionPercent,
    paramCount,
    masterTestId,
    deleteStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabTest &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.department == this.department &&
          other.description == this.description &&
          other.price == this.price &&
          other.maxDisc == this.maxDisc &&
          other.commissionPercent == this.commissionPercent &&
          other.paramCount == this.paramCount &&
          other.masterTestId == this.masterTestId &&
          other.deleteStatus == this.deleteStatus &&
          other.createdAt == this.createdAt);
}

class LabTestsCompanion extends UpdateCompanion<LabTest> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> department;
  final Value<String> description;
  final Value<double> price;
  final Value<double> maxDisc;
  final Value<double?> commissionPercent;
  final Value<int> paramCount;
  final Value<int?> masterTestId;
  final Value<bool> deleteStatus;
  final Value<DateTime> createdAt;
  const LabTestsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.department = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.maxDisc = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.paramCount = const Value.absent(),
    this.masterTestId = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LabTestsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.department = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.maxDisc = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.paramCount = const Value.absent(),
    this.masterTestId = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<LabTest> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? department,
    Expression<String>? description,
    Expression<double>? price,
    Expression<double>? maxDisc,
    Expression<double>? commissionPercent,
    Expression<int>? paramCount,
    Expression<int>? masterTestId,
    Expression<bool>? deleteStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (department != null) 'department': department,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (maxDisc != null) 'max_disc': maxDisc,
      if (commissionPercent != null) 'commission_percent': commissionPercent,
      if (paramCount != null) 'param_count': paramCount,
      if (masterTestId != null) 'master_test_id': masterTestId,
      if (deleteStatus != null) 'delete_status': deleteStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LabTestsCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? department,
    Value<String>? description,
    Value<double>? price,
    Value<double>? maxDisc,
    Value<double?>? commissionPercent,
    Value<int>? paramCount,
    Value<int?>? masterTestId,
    Value<bool>? deleteStatus,
    Value<DateTime>? createdAt,
  }) {
    return LabTestsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      department: department ?? this.department,
      description: description ?? this.description,
      price: price ?? this.price,
      maxDisc: maxDisc ?? this.maxDisc,
      commissionPercent: commissionPercent ?? this.commissionPercent,
      paramCount: paramCount ?? this.paramCount,
      masterTestId: masterTestId ?? this.masterTestId,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (maxDisc.present) {
      map['max_disc'] = Variable<double>(maxDisc.value);
    }
    if (commissionPercent.present) {
      map['commission_percent'] = Variable<double>(commissionPercent.value);
    }
    if (paramCount.present) {
      map['param_count'] = Variable<int>(paramCount.value);
    }
    if (masterTestId.present) {
      map['master_test_id'] = Variable<int>(masterTestId.value);
    }
    if (deleteStatus.present) {
      map['delete_status'] = Variable<bool>(deleteStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabTestsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('department: $department, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('maxDisc: $maxDisc, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('paramCount: $paramCount, ')
          ..write('masterTestId: $masterTestId, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TestParametersTable extends TestParameters
    with TableInfo<$TestParametersTable, TestParameter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestParametersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lab_tests (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _valueTypeMeta = const VerificationMeta(
    'valueType',
  );
  @override
  late final GeneratedColumn<String> valueType = GeneratedColumn<String>(
    'value_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('float'),
  );
  static const VerificationMeta _formulaMeta = const VerificationMeta(
    'formula',
  );
  @override
  late final GeneratedColumn<String> formula = GeneratedColumn<String>(
    'formula',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _maleRangeMeta = const VerificationMeta(
    'maleRange',
  );
  @override
  late final GeneratedColumn<String> maleRange = GeneratedColumn<String>(
    'male_range',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _femaleRangeMeta = const VerificationMeta(
    'femaleRange',
  );
  @override
  late final GeneratedColumn<String> femaleRange = GeneratedColumn<String>(
    'female_range',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sectionTitleMeta = const VerificationMeta(
    'sectionTitle',
  );
  @override
  late final GeneratedColumn<String> sectionTitle = GeneratedColumn<String>(
    'section_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupSumEqualsMeta = const VerificationMeta(
    'groupSumEquals',
  );
  @override
  late final GeneratedColumn<double> groupSumEquals = GeneratedColumn<double>(
    'group_sum_equals',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _masterParameterIdMeta = const VerificationMeta(
    'masterParameterId',
  );
  @override
  late final GeneratedColumn<int> masterParameterId = GeneratedColumn<int>(
    'master_parameter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deleteStatusMeta = const VerificationMeta(
    'deleteStatus',
  );
  @override
  late final GeneratedColumn<bool> deleteStatus = GeneratedColumn<bool>(
    'delete_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    testId,
    title,
    unit,
    valueType,
    formula,
    maleRange,
    femaleRange,
    sortOrder,
    sectionTitle,
    groupSumEquals,
    masterParameterId,
    deleteStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_parameters';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestParameter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('value_type')) {
      context.handle(
        _valueTypeMeta,
        valueType.isAcceptableOrUnknown(data['value_type']!, _valueTypeMeta),
      );
    }
    if (data.containsKey('formula')) {
      context.handle(
        _formulaMeta,
        formula.isAcceptableOrUnknown(data['formula']!, _formulaMeta),
      );
    }
    if (data.containsKey('male_range')) {
      context.handle(
        _maleRangeMeta,
        maleRange.isAcceptableOrUnknown(data['male_range']!, _maleRangeMeta),
      );
    }
    if (data.containsKey('female_range')) {
      context.handle(
        _femaleRangeMeta,
        femaleRange.isAcceptableOrUnknown(
          data['female_range']!,
          _femaleRangeMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('section_title')) {
      context.handle(
        _sectionTitleMeta,
        sectionTitle.isAcceptableOrUnknown(
          data['section_title']!,
          _sectionTitleMeta,
        ),
      );
    }
    if (data.containsKey('group_sum_equals')) {
      context.handle(
        _groupSumEqualsMeta,
        groupSumEquals.isAcceptableOrUnknown(
          data['group_sum_equals']!,
          _groupSumEqualsMeta,
        ),
      );
    }
    if (data.containsKey('master_parameter_id')) {
      context.handle(
        _masterParameterIdMeta,
        masterParameterId.isAcceptableOrUnknown(
          data['master_parameter_id']!,
          _masterParameterIdMeta,
        ),
      );
    }
    if (data.containsKey('delete_status')) {
      context.handle(
        _deleteStatusMeta,
        deleteStatus.isAcceptableOrUnknown(
          data['delete_status']!,
          _deleteStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestParameter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestParameter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}test_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      valueType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_type'],
      )!,
      formula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula'],
      )!,
      maleRange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}male_range'],
      )!,
      femaleRange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}female_range'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      sectionTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_title'],
      ),
      groupSumEquals: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}group_sum_equals'],
      ),
      masterParameterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}master_parameter_id'],
      ),
      deleteStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_status'],
      )!,
    );
  }

  @override
  $TestParametersTable createAlias(String alias) {
    return $TestParametersTable(attachedDatabase, alias);
  }
}

class TestParameter extends DataClass implements Insertable<TestParameter> {
  final int id;
  final int testId;
  final String title;
  final String unit;
  final String valueType;
  final String formula;
  final String maleRange;
  final String femaleRange;
  final int sortOrder;
  final String? sectionTitle;
  final double? groupSumEquals;
  final int? masterParameterId;
  final bool deleteStatus;
  const TestParameter({
    required this.id,
    required this.testId,
    required this.title,
    required this.unit,
    required this.valueType,
    required this.formula,
    required this.maleRange,
    required this.femaleRange,
    required this.sortOrder,
    this.sectionTitle,
    this.groupSumEquals,
    this.masterParameterId,
    required this.deleteStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['test_id'] = Variable<int>(testId);
    map['title'] = Variable<String>(title);
    map['unit'] = Variable<String>(unit);
    map['value_type'] = Variable<String>(valueType);
    map['formula'] = Variable<String>(formula);
    map['male_range'] = Variable<String>(maleRange);
    map['female_range'] = Variable<String>(femaleRange);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || sectionTitle != null) {
      map['section_title'] = Variable<String>(sectionTitle);
    }
    if (!nullToAbsent || groupSumEquals != null) {
      map['group_sum_equals'] = Variable<double>(groupSumEquals);
    }
    if (!nullToAbsent || masterParameterId != null) {
      map['master_parameter_id'] = Variable<int>(masterParameterId);
    }
    map['delete_status'] = Variable<bool>(deleteStatus);
    return map;
  }

  TestParametersCompanion toCompanion(bool nullToAbsent) {
    return TestParametersCompanion(
      id: Value(id),
      testId: Value(testId),
      title: Value(title),
      unit: Value(unit),
      valueType: Value(valueType),
      formula: Value(formula),
      maleRange: Value(maleRange),
      femaleRange: Value(femaleRange),
      sortOrder: Value(sortOrder),
      sectionTitle: sectionTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionTitle),
      groupSumEquals: groupSumEquals == null && nullToAbsent
          ? const Value.absent()
          : Value(groupSumEquals),
      masterParameterId: masterParameterId == null && nullToAbsent
          ? const Value.absent()
          : Value(masterParameterId),
      deleteStatus: Value(deleteStatus),
    );
  }

  factory TestParameter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestParameter(
      id: serializer.fromJson<int>(json['id']),
      testId: serializer.fromJson<int>(json['testId']),
      title: serializer.fromJson<String>(json['title']),
      unit: serializer.fromJson<String>(json['unit']),
      valueType: serializer.fromJson<String>(json['valueType']),
      formula: serializer.fromJson<String>(json['formula']),
      maleRange: serializer.fromJson<String>(json['maleRange']),
      femaleRange: serializer.fromJson<String>(json['femaleRange']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      sectionTitle: serializer.fromJson<String?>(json['sectionTitle']),
      groupSumEquals: serializer.fromJson<double?>(json['groupSumEquals']),
      masterParameterId: serializer.fromJson<int?>(json['masterParameterId']),
      deleteStatus: serializer.fromJson<bool>(json['deleteStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'testId': serializer.toJson<int>(testId),
      'title': serializer.toJson<String>(title),
      'unit': serializer.toJson<String>(unit),
      'valueType': serializer.toJson<String>(valueType),
      'formula': serializer.toJson<String>(formula),
      'maleRange': serializer.toJson<String>(maleRange),
      'femaleRange': serializer.toJson<String>(femaleRange),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'sectionTitle': serializer.toJson<String?>(sectionTitle),
      'groupSumEquals': serializer.toJson<double?>(groupSumEquals),
      'masterParameterId': serializer.toJson<int?>(masterParameterId),
      'deleteStatus': serializer.toJson<bool>(deleteStatus),
    };
  }

  TestParameter copyWith({
    int? id,
    int? testId,
    String? title,
    String? unit,
    String? valueType,
    String? formula,
    String? maleRange,
    String? femaleRange,
    int? sortOrder,
    Value<String?> sectionTitle = const Value.absent(),
    Value<double?> groupSumEquals = const Value.absent(),
    Value<int?> masterParameterId = const Value.absent(),
    bool? deleteStatus,
  }) => TestParameter(
    id: id ?? this.id,
    testId: testId ?? this.testId,
    title: title ?? this.title,
    unit: unit ?? this.unit,
    valueType: valueType ?? this.valueType,
    formula: formula ?? this.formula,
    maleRange: maleRange ?? this.maleRange,
    femaleRange: femaleRange ?? this.femaleRange,
    sortOrder: sortOrder ?? this.sortOrder,
    sectionTitle: sectionTitle.present ? sectionTitle.value : this.sectionTitle,
    groupSumEquals: groupSumEquals.present
        ? groupSumEquals.value
        : this.groupSumEquals,
    masterParameterId: masterParameterId.present
        ? masterParameterId.value
        : this.masterParameterId,
    deleteStatus: deleteStatus ?? this.deleteStatus,
  );
  TestParameter copyWithCompanion(TestParametersCompanion data) {
    return TestParameter(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      title: data.title.present ? data.title.value : this.title,
      unit: data.unit.present ? data.unit.value : this.unit,
      valueType: data.valueType.present ? data.valueType.value : this.valueType,
      formula: data.formula.present ? data.formula.value : this.formula,
      maleRange: data.maleRange.present ? data.maleRange.value : this.maleRange,
      femaleRange: data.femaleRange.present
          ? data.femaleRange.value
          : this.femaleRange,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      sectionTitle: data.sectionTitle.present
          ? data.sectionTitle.value
          : this.sectionTitle,
      groupSumEquals: data.groupSumEquals.present
          ? data.groupSumEquals.value
          : this.groupSumEquals,
      masterParameterId: data.masterParameterId.present
          ? data.masterParameterId.value
          : this.masterParameterId,
      deleteStatus: data.deleteStatus.present
          ? data.deleteStatus.value
          : this.deleteStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestParameter(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('title: $title, ')
          ..write('unit: $unit, ')
          ..write('valueType: $valueType, ')
          ..write('formula: $formula, ')
          ..write('maleRange: $maleRange, ')
          ..write('femaleRange: $femaleRange, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('sectionTitle: $sectionTitle, ')
          ..write('groupSumEquals: $groupSumEquals, ')
          ..write('masterParameterId: $masterParameterId, ')
          ..write('deleteStatus: $deleteStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    testId,
    title,
    unit,
    valueType,
    formula,
    maleRange,
    femaleRange,
    sortOrder,
    sectionTitle,
    groupSumEquals,
    masterParameterId,
    deleteStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestParameter &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.title == this.title &&
          other.unit == this.unit &&
          other.valueType == this.valueType &&
          other.formula == this.formula &&
          other.maleRange == this.maleRange &&
          other.femaleRange == this.femaleRange &&
          other.sortOrder == this.sortOrder &&
          other.sectionTitle == this.sectionTitle &&
          other.groupSumEquals == this.groupSumEquals &&
          other.masterParameterId == this.masterParameterId &&
          other.deleteStatus == this.deleteStatus);
}

class TestParametersCompanion extends UpdateCompanion<TestParameter> {
  final Value<int> id;
  final Value<int> testId;
  final Value<String> title;
  final Value<String> unit;
  final Value<String> valueType;
  final Value<String> formula;
  final Value<String> maleRange;
  final Value<String> femaleRange;
  final Value<int> sortOrder;
  final Value<String?> sectionTitle;
  final Value<double?> groupSumEquals;
  final Value<int?> masterParameterId;
  final Value<bool> deleteStatus;
  const TestParametersCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.title = const Value.absent(),
    this.unit = const Value.absent(),
    this.valueType = const Value.absent(),
    this.formula = const Value.absent(),
    this.maleRange = const Value.absent(),
    this.femaleRange = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.sectionTitle = const Value.absent(),
    this.groupSumEquals = const Value.absent(),
    this.masterParameterId = const Value.absent(),
    this.deleteStatus = const Value.absent(),
  });
  TestParametersCompanion.insert({
    this.id = const Value.absent(),
    required int testId,
    required String title,
    this.unit = const Value.absent(),
    this.valueType = const Value.absent(),
    this.formula = const Value.absent(),
    this.maleRange = const Value.absent(),
    this.femaleRange = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.sectionTitle = const Value.absent(),
    this.groupSumEquals = const Value.absent(),
    this.masterParameterId = const Value.absent(),
    this.deleteStatus = const Value.absent(),
  }) : testId = Value(testId),
       title = Value(title);
  static Insertable<TestParameter> custom({
    Expression<int>? id,
    Expression<int>? testId,
    Expression<String>? title,
    Expression<String>? unit,
    Expression<String>? valueType,
    Expression<String>? formula,
    Expression<String>? maleRange,
    Expression<String>? femaleRange,
    Expression<int>? sortOrder,
    Expression<String>? sectionTitle,
    Expression<double>? groupSumEquals,
    Expression<int>? masterParameterId,
    Expression<bool>? deleteStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (title != null) 'title': title,
      if (unit != null) 'unit': unit,
      if (valueType != null) 'value_type': valueType,
      if (formula != null) 'formula': formula,
      if (maleRange != null) 'male_range': maleRange,
      if (femaleRange != null) 'female_range': femaleRange,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (sectionTitle != null) 'section_title': sectionTitle,
      if (groupSumEquals != null) 'group_sum_equals': groupSumEquals,
      if (masterParameterId != null) 'master_parameter_id': masterParameterId,
      if (deleteStatus != null) 'delete_status': deleteStatus,
    });
  }

  TestParametersCompanion copyWith({
    Value<int>? id,
    Value<int>? testId,
    Value<String>? title,
    Value<String>? unit,
    Value<String>? valueType,
    Value<String>? formula,
    Value<String>? maleRange,
    Value<String>? femaleRange,
    Value<int>? sortOrder,
    Value<String?>? sectionTitle,
    Value<double?>? groupSumEquals,
    Value<int?>? masterParameterId,
    Value<bool>? deleteStatus,
  }) {
    return TestParametersCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      title: title ?? this.title,
      unit: unit ?? this.unit,
      valueType: valueType ?? this.valueType,
      formula: formula ?? this.formula,
      maleRange: maleRange ?? this.maleRange,
      femaleRange: femaleRange ?? this.femaleRange,
      sortOrder: sortOrder ?? this.sortOrder,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      groupSumEquals: groupSumEquals ?? this.groupSumEquals,
      masterParameterId: masterParameterId ?? this.masterParameterId,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (valueType.present) {
      map['value_type'] = Variable<String>(valueType.value);
    }
    if (formula.present) {
      map['formula'] = Variable<String>(formula.value);
    }
    if (maleRange.present) {
      map['male_range'] = Variable<String>(maleRange.value);
    }
    if (femaleRange.present) {
      map['female_range'] = Variable<String>(femaleRange.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (sectionTitle.present) {
      map['section_title'] = Variable<String>(sectionTitle.value);
    }
    if (groupSumEquals.present) {
      map['group_sum_equals'] = Variable<double>(groupSumEquals.value);
    }
    if (masterParameterId.present) {
      map['master_parameter_id'] = Variable<int>(masterParameterId.value);
    }
    if (deleteStatus.present) {
      map['delete_status'] = Variable<bool>(deleteStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestParametersCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('title: $title, ')
          ..write('unit: $unit, ')
          ..write('valueType: $valueType, ')
          ..write('formula: $formula, ')
          ..write('maleRange: $maleRange, ')
          ..write('femaleRange: $femaleRange, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('sectionTitle: $sectionTitle, ')
          ..write('groupSumEquals: $groupSumEquals, ')
          ..write('masterParameterId: $masterParameterId, ')
          ..write('deleteStatus: $deleteStatus')
          ..write(')'))
        .toString();
  }
}

class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _prefixMeta = const VerificationMeta('prefix');
  @override
  late final GeneratedColumn<String> prefix = GeneratedColumn<String>(
    'prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<int> doctorId = GeneratedColumn<int>(
    'doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES doctors (id)',
    ),
  );
  static const VerificationMeta _referredByMeta = const VerificationMeta(
    'referredBy',
  );
  @override
  late final GeneratedColumn<String> referredBy = GeneratedColumn<String>(
    'referred_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _payableAmountMeta = const VerificationMeta(
    'payableAmount',
  );
  @override
  late final GeneratedColumn<double> payableAmount = GeneratedColumn<double>(
    'payable_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Pending'),
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deleteStatusMeta = const VerificationMeta(
    'deleteStatus',
  );
  @override
  late final GeneratedColumn<bool> deleteStatus = GeneratedColumn<bool>(
    'delete_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    prefix,
    firstName,
    lastName,
    age,
    sex,
    phone,
    email,
    address,
    doctorId,
    referredBy,
    totalAmount,
    discountAmount,
    discountPercent,
    payableAmount,
    paidAmount,
    paymentMethod,
    remark,
    status,
    approvedAt,
    deleteStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Patient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prefix')) {
      context.handle(
        _prefixMeta,
        prefix.isAcceptableOrUnknown(data['prefix']!, _prefixMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    }
    if (data.containsKey('referred_by')) {
      context.handle(
        _referredByMeta,
        referredBy.isAcceptableOrUnknown(data['referred_by']!, _referredByMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('payable_amount')) {
      context.handle(
        _payableAmountMeta,
        payableAmount.isAcceptableOrUnknown(
          data['payable_amount']!,
          _payableAmountMeta,
        ),
      );
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    }
    if (data.containsKey('delete_status')) {
      context.handle(
        _deleteStatusMeta,
        deleteStatus.isAcceptableOrUnknown(
          data['delete_status']!,
          _deleteStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      prefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prefix'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}doctor_id'],
      ),
      referredBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referred_by'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      payableAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payable_amount'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      ),
      deleteStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
  final int id;
  final String prefix;
  final String firstName;
  final String lastName;
  final int? age;
  final String sex;
  final String phone;
  final String email;
  final String address;
  final int? doctorId;
  final String referredBy;
  final double totalAmount;
  final double discountAmount;
  final double discountPercent;
  final double payableAmount;
  final double paidAmount;
  final String paymentMethod;
  final String remark;
  final String status;
  final DateTime? approvedAt;
  final bool deleteStatus;
  final DateTime createdAt;
  const Patient({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    this.age,
    required this.sex,
    required this.phone,
    required this.email,
    required this.address,
    this.doctorId,
    required this.referredBy,
    required this.totalAmount,
    required this.discountAmount,
    required this.discountPercent,
    required this.payableAmount,
    required this.paidAmount,
    required this.paymentMethod,
    required this.remark,
    required this.status,
    this.approvedAt,
    required this.deleteStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prefix'] = Variable<String>(prefix);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    map['sex'] = Variable<String>(sex);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<int>(doctorId);
    }
    map['referred_by'] = Variable<String>(referredBy);
    map['total_amount'] = Variable<double>(totalAmount);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['payable_amount'] = Variable<double>(payableAmount);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['remark'] = Variable<String>(remark);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    map['delete_status'] = Variable<bool>(deleteStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      prefix: Value(prefix),
      firstName: Value(firstName),
      lastName: Value(lastName),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      sex: Value(sex),
      phone: Value(phone),
      email: Value(email),
      address: Value(address),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      referredBy: Value(referredBy),
      totalAmount: Value(totalAmount),
      discountAmount: Value(discountAmount),
      discountPercent: Value(discountPercent),
      payableAmount: Value(payableAmount),
      paidAmount: Value(paidAmount),
      paymentMethod: Value(paymentMethod),
      remark: Value(remark),
      status: Value(status),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
      deleteStatus: Value(deleteStatus),
      createdAt: Value(createdAt),
    );
  }

  factory Patient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      prefix: serializer.fromJson<String>(json['prefix']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      age: serializer.fromJson<int?>(json['age']),
      sex: serializer.fromJson<String>(json['sex']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      address: serializer.fromJson<String>(json['address']),
      doctorId: serializer.fromJson<int?>(json['doctorId']),
      referredBy: serializer.fromJson<String>(json['referredBy']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      payableAmount: serializer.fromJson<double>(json['payableAmount']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      remark: serializer.fromJson<String>(json['remark']),
      status: serializer.fromJson<String>(json['status']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
      deleteStatus: serializer.fromJson<bool>(json['deleteStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prefix': serializer.toJson<String>(prefix),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'age': serializer.toJson<int?>(age),
      'sex': serializer.toJson<String>(sex),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'address': serializer.toJson<String>(address),
      'doctorId': serializer.toJson<int?>(doctorId),
      'referredBy': serializer.toJson<String>(referredBy),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'payableAmount': serializer.toJson<double>(payableAmount),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'remark': serializer.toJson<String>(remark),
      'status': serializer.toJson<String>(status),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
      'deleteStatus': serializer.toJson<bool>(deleteStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Patient copyWith({
    int? id,
    String? prefix,
    String? firstName,
    String? lastName,
    Value<int?> age = const Value.absent(),
    String? sex,
    String? phone,
    String? email,
    String? address,
    Value<int?> doctorId = const Value.absent(),
    String? referredBy,
    double? totalAmount,
    double? discountAmount,
    double? discountPercent,
    double? payableAmount,
    double? paidAmount,
    String? paymentMethod,
    String? remark,
    String? status,
    Value<DateTime?> approvedAt = const Value.absent(),
    bool? deleteStatus,
    DateTime? createdAt,
  }) => Patient(
    id: id ?? this.id,
    prefix: prefix ?? this.prefix,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    age: age.present ? age.value : this.age,
    sex: sex ?? this.sex,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    address: address ?? this.address,
    doctorId: doctorId.present ? doctorId.value : this.doctorId,
    referredBy: referredBy ?? this.referredBy,
    totalAmount: totalAmount ?? this.totalAmount,
    discountAmount: discountAmount ?? this.discountAmount,
    discountPercent: discountPercent ?? this.discountPercent,
    payableAmount: payableAmount ?? this.payableAmount,
    paidAmount: paidAmount ?? this.paidAmount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    remark: remark ?? this.remark,
    status: status ?? this.status,
    approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      prefix: data.prefix.present ? data.prefix.value : this.prefix,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      age: data.age.present ? data.age.value : this.age,
      sex: data.sex.present ? data.sex.value : this.sex,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      referredBy: data.referredBy.present
          ? data.referredBy.value
          : this.referredBy,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      payableAmount: data.payableAmount.present
          ? data.payableAmount.value
          : this.payableAmount,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      remark: data.remark.present ? data.remark.value : this.remark,
      status: data.status.present ? data.status.value : this.status,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
      deleteStatus: data.deleteStatus.present
          ? data.deleteStatus.value
          : this.deleteStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('doctorId: $doctorId, ')
          ..write('referredBy: $referredBy, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('payableAmount: $payableAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('remark: $remark, ')
          ..write('status: $status, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    prefix,
    firstName,
    lastName,
    age,
    sex,
    phone,
    email,
    address,
    doctorId,
    referredBy,
    totalAmount,
    discountAmount,
    discountPercent,
    payableAmount,
    paidAmount,
    paymentMethod,
    remark,
    status,
    approvedAt,
    deleteStatus,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.prefix == this.prefix &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.age == this.age &&
          other.sex == this.sex &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.doctorId == this.doctorId &&
          other.referredBy == this.referredBy &&
          other.totalAmount == this.totalAmount &&
          other.discountAmount == this.discountAmount &&
          other.discountPercent == this.discountPercent &&
          other.payableAmount == this.payableAmount &&
          other.paidAmount == this.paidAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.remark == this.remark &&
          other.status == this.status &&
          other.approvedAt == this.approvedAt &&
          other.deleteStatus == this.deleteStatus &&
          other.createdAt == this.createdAt);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> prefix;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int?> age;
  final Value<String> sex;
  final Value<String> phone;
  final Value<String> email;
  final Value<String> address;
  final Value<int?> doctorId;
  final Value<String> referredBy;
  final Value<double> totalAmount;
  final Value<double> discountAmount;
  final Value<double> discountPercent;
  final Value<double> payableAmount;
  final Value<double> paidAmount;
  final Value<String> paymentMethod;
  final Value<String> remark;
  final Value<String> status;
  final Value<DateTime?> approvedAt;
  final Value<bool> deleteStatus;
  final Value<DateTime> createdAt;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.prefix = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.referredBy = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.payableAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.remark = const Value.absent(),
    this.status = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    this.prefix = const Value.absent(),
    required String firstName,
    this.lastName = const Value.absent(),
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.referredBy = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.payableAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.remark = const Value.absent(),
    this.status = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : firstName = Value(firstName);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? prefix,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? age,
    Expression<String>? sex,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<int>? doctorId,
    Expression<String>? referredBy,
    Expression<double>? totalAmount,
    Expression<double>? discountAmount,
    Expression<double>? discountPercent,
    Expression<double>? payableAmount,
    Expression<double>? paidAmount,
    Expression<String>? paymentMethod,
    Expression<String>? remark,
    Expression<String>? status,
    Expression<DateTime>? approvedAt,
    Expression<bool>? deleteStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prefix != null) 'prefix': prefix,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (age != null) 'age': age,
      if (sex != null) 'sex': sex,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (doctorId != null) 'doctor_id': doctorId,
      if (referredBy != null) 'referred_by': referredBy,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (payableAmount != null) 'payable_amount': payableAmount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (remark != null) 'remark': remark,
      if (status != null) 'status': status,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (deleteStatus != null) 'delete_status': deleteStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PatientsCompanion copyWith({
    Value<int>? id,
    Value<String>? prefix,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<int?>? age,
    Value<String>? sex,
    Value<String>? phone,
    Value<String>? email,
    Value<String>? address,
    Value<int?>? doctorId,
    Value<String>? referredBy,
    Value<double>? totalAmount,
    Value<double>? discountAmount,
    Value<double>? discountPercent,
    Value<double>? payableAmount,
    Value<double>? paidAmount,
    Value<String>? paymentMethod,
    Value<String>? remark,
    Value<String>? status,
    Value<DateTime?>? approvedAt,
    Value<bool>? deleteStatus,
    Value<DateTime>? createdAt,
  }) {
    return PatientsCompanion(
      id: id ?? this.id,
      prefix: prefix ?? this.prefix,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      doctorId: doctorId ?? this.doctorId,
      referredBy: referredBy ?? this.referredBy,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      payableAmount: payableAmount ?? this.payableAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      remark: remark ?? this.remark,
      status: status ?? this.status,
      approvedAt: approvedAt ?? this.approvedAt,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prefix.present) {
      map['prefix'] = Variable<String>(prefix.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<int>(doctorId.value);
    }
    if (referredBy.present) {
      map['referred_by'] = Variable<String>(referredBy.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (payableAmount.present) {
      map['payable_amount'] = Variable<double>(payableAmount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (deleteStatus.present) {
      map['delete_status'] = Variable<bool>(deleteStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('doctorId: $doctorId, ')
          ..write('referredBy: $referredBy, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('payableAmount: $payableAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('remark: $remark, ')
          ..write('status: $status, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PatientTestsTable extends PatientTests
    with TableInfo<$PatientTestsTable, PatientTest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientTestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lab_tests (id)',
    ),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deleteStatusMeta = const VerificationMeta(
    'deleteStatus',
  );
  @override
  late final GeneratedColumn<bool> deleteStatus = GeneratedColumn<bool>(
    'delete_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_status" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    testId,
    price,
    deleteStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatientTest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('delete_status')) {
      context.handle(
        _deleteStatusMeta,
        deleteStatus.isAcceptableOrUnknown(
          data['delete_status']!,
          _deleteStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientTest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientTest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patient_id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}test_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      deleteStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PatientTestsTable createAlias(String alias) {
    return $PatientTestsTable(attachedDatabase, alias);
  }
}

class PatientTest extends DataClass implements Insertable<PatientTest> {
  final int id;
  final int patientId;
  final int testId;
  final double price;
  final bool deleteStatus;
  final DateTime createdAt;
  const PatientTest({
    required this.id,
    required this.patientId,
    required this.testId,
    required this.price,
    required this.deleteStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['test_id'] = Variable<int>(testId);
    map['price'] = Variable<double>(price);
    map['delete_status'] = Variable<bool>(deleteStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PatientTestsCompanion toCompanion(bool nullToAbsent) {
    return PatientTestsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      testId: Value(testId),
      price: Value(price),
      deleteStatus: Value(deleteStatus),
      createdAt: Value(createdAt),
    );
  }

  factory PatientTest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientTest(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      testId: serializer.fromJson<int>(json['testId']),
      price: serializer.fromJson<double>(json['price']),
      deleteStatus: serializer.fromJson<bool>(json['deleteStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'testId': serializer.toJson<int>(testId),
      'price': serializer.toJson<double>(price),
      'deleteStatus': serializer.toJson<bool>(deleteStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PatientTest copyWith({
    int? id,
    int? patientId,
    int? testId,
    double? price,
    bool? deleteStatus,
    DateTime? createdAt,
  }) => PatientTest(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    testId: testId ?? this.testId,
    price: price ?? this.price,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  PatientTest copyWithCompanion(PatientTestsCompanion data) {
    return PatientTest(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      testId: data.testId.present ? data.testId.value : this.testId,
      price: data.price.present ? data.price.value : this.price,
      deleteStatus: data.deleteStatus.present
          ? data.deleteStatus.value
          : this.deleteStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientTest(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testId: $testId, ')
          ..write('price: $price, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, testId, price, deleteStatus, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientTest &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.testId == this.testId &&
          other.price == this.price &&
          other.deleteStatus == this.deleteStatus &&
          other.createdAt == this.createdAt);
}

class PatientTestsCompanion extends UpdateCompanion<PatientTest> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<int> testId;
  final Value<double> price;
  final Value<bool> deleteStatus;
  final Value<DateTime> createdAt;
  const PatientTestsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.testId = const Value.absent(),
    this.price = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PatientTestsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required int testId,
    this.price = const Value.absent(),
    this.deleteStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : patientId = Value(patientId),
       testId = Value(testId);
  static Insertable<PatientTest> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<int>? testId,
    Expression<double>? price,
    Expression<bool>? deleteStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (testId != null) 'test_id': testId,
      if (price != null) 'price': price,
      if (deleteStatus != null) 'delete_status': deleteStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PatientTestsCompanion copyWith({
    Value<int>? id,
    Value<int>? patientId,
    Value<int>? testId,
    Value<double>? price,
    Value<bool>? deleteStatus,
    Value<DateTime>? createdAt,
  }) {
    return PatientTestsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      testId: testId ?? this.testId,
      price: price ?? this.price,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (deleteStatus.present) {
      map['delete_status'] = Variable<bool>(deleteStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientTestsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('testId: $testId, ')
          ..write('price: $price, ')
          ..write('deleteStatus: $deleteStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TestReadingsTable extends TestReadings
    with TableInfo<$TestReadingsTable, TestReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _patientTestIdMeta = const VerificationMeta(
    'patientTestId',
  );
  @override
  late final GeneratedColumn<int> patientTestId = GeneratedColumn<int>(
    'patient_test_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patient_tests (id)',
    ),
  );
  static const VerificationMeta _testParameterIdMeta = const VerificationMeta(
    'testParameterId',
  );
  @override
  late final GeneratedColumn<int> testParameterId = GeneratedColumn<int>(
    'test_parameter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES test_parameters (id)',
    ),
  );
  static const VerificationMeta _parameterNameMeta = const VerificationMeta(
    'parameterName',
  );
  @override
  late final GeneratedColumn<String> parameterName = GeneratedColumn<String>(
    'parameter_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    patientTestId,
    testParameterId,
    parameterName,
    value,
    unit,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<TestReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('patient_test_id')) {
      context.handle(
        _patientTestIdMeta,
        patientTestId.isAcceptableOrUnknown(
          data['patient_test_id']!,
          _patientTestIdMeta,
        ),
      );
    }
    if (data.containsKey('test_parameter_id')) {
      context.handle(
        _testParameterIdMeta,
        testParameterId.isAcceptableOrUnknown(
          data['test_parameter_id']!,
          _testParameterIdMeta,
        ),
      );
    }
    if (data.containsKey('parameter_name')) {
      context.handle(
        _parameterNameMeta,
        parameterName.isAcceptableOrUnknown(
          data['parameter_name']!,
          _parameterNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parameterNameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patient_id'],
      )!,
      patientTestId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patient_test_id'],
      ),
      testParameterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}test_parameter_id'],
      ),
      parameterName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parameter_name'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TestReadingsTable createAlias(String alias) {
    return $TestReadingsTable(attachedDatabase, alias);
  }
}

class TestReading extends DataClass implements Insertable<TestReading> {
  final int id;
  final int patientId;
  final int? patientTestId;
  final int? testParameterId;
  final String parameterName;
  final String value;
  final String unit;
  final DateTime updatedAt;
  const TestReading({
    required this.id,
    required this.patientId,
    this.patientTestId,
    this.testParameterId,
    required this.parameterName,
    required this.value,
    required this.unit,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    if (!nullToAbsent || patientTestId != null) {
      map['patient_test_id'] = Variable<int>(patientTestId);
    }
    if (!nullToAbsent || testParameterId != null) {
      map['test_parameter_id'] = Variable<int>(testParameterId);
    }
    map['parameter_name'] = Variable<String>(parameterName);
    map['value'] = Variable<String>(value);
    map['unit'] = Variable<String>(unit);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TestReadingsCompanion toCompanion(bool nullToAbsent) {
    return TestReadingsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      patientTestId: patientTestId == null && nullToAbsent
          ? const Value.absent()
          : Value(patientTestId),
      testParameterId: testParameterId == null && nullToAbsent
          ? const Value.absent()
          : Value(testParameterId),
      parameterName: Value(parameterName),
      value: Value(value),
      unit: Value(unit),
      updatedAt: Value(updatedAt),
    );
  }

  factory TestReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestReading(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      patientTestId: serializer.fromJson<int?>(json['patientTestId']),
      testParameterId: serializer.fromJson<int?>(json['testParameterId']),
      parameterName: serializer.fromJson<String>(json['parameterName']),
      value: serializer.fromJson<String>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'patientTestId': serializer.toJson<int?>(patientTestId),
      'testParameterId': serializer.toJson<int?>(testParameterId),
      'parameterName': serializer.toJson<String>(parameterName),
      'value': serializer.toJson<String>(value),
      'unit': serializer.toJson<String>(unit),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TestReading copyWith({
    int? id,
    int? patientId,
    Value<int?> patientTestId = const Value.absent(),
    Value<int?> testParameterId = const Value.absent(),
    String? parameterName,
    String? value,
    String? unit,
    DateTime? updatedAt,
  }) => TestReading(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    patientTestId: patientTestId.present
        ? patientTestId.value
        : this.patientTestId,
    testParameterId: testParameterId.present
        ? testParameterId.value
        : this.testParameterId,
    parameterName: parameterName ?? this.parameterName,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TestReading copyWithCompanion(TestReadingsCompanion data) {
    return TestReading(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      patientTestId: data.patientTestId.present
          ? data.patientTestId.value
          : this.patientTestId,
      testParameterId: data.testParameterId.present
          ? data.testParameterId.value
          : this.testParameterId,
      parameterName: data.parameterName.present
          ? data.parameterName.value
          : this.parameterName,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestReading(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientTestId: $patientTestId, ')
          ..write('testParameterId: $testParameterId, ')
          ..write('parameterName: $parameterName, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    patientTestId,
    testParameterId,
    parameterName,
    value,
    unit,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestReading &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.patientTestId == this.patientTestId &&
          other.testParameterId == this.testParameterId &&
          other.parameterName == this.parameterName &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.updatedAt == this.updatedAt);
}

class TestReadingsCompanion extends UpdateCompanion<TestReading> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<int?> patientTestId;
  final Value<int?> testParameterId;
  final Value<String> parameterName;
  final Value<String> value;
  final Value<String> unit;
  final Value<DateTime> updatedAt;
  const TestReadingsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.patientTestId = const Value.absent(),
    this.testParameterId = const Value.absent(),
    this.parameterName = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TestReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    this.patientTestId = const Value.absent(),
    this.testParameterId = const Value.absent(),
    required String parameterName,
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : patientId = Value(patientId),
       parameterName = Value(parameterName);
  static Insertable<TestReading> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<int>? patientTestId,
    Expression<int>? testParameterId,
    Expression<String>? parameterName,
    Expression<String>? value,
    Expression<String>? unit,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (patientTestId != null) 'patient_test_id': patientTestId,
      if (testParameterId != null) 'test_parameter_id': testParameterId,
      if (parameterName != null) 'parameter_name': parameterName,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TestReadingsCompanion copyWith({
    Value<int>? id,
    Value<int>? patientId,
    Value<int?>? patientTestId,
    Value<int?>? testParameterId,
    Value<String>? parameterName,
    Value<String>? value,
    Value<String>? unit,
    Value<DateTime>? updatedAt,
  }) {
    return TestReadingsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientTestId: patientTestId ?? this.patientTestId,
      testParameterId: testParameterId ?? this.testParameterId,
      parameterName: parameterName ?? this.parameterName,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (patientTestId.present) {
      map['patient_test_id'] = Variable<int>(patientTestId.value);
    }
    if (testParameterId.present) {
      map['test_parameter_id'] = Variable<int>(testParameterId.value);
    }
    if (parameterName.present) {
      map['parameter_name'] = Variable<String>(parameterName.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestReadingsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('patientTestId: $patientTestId, ')
          ..write('testParameterId: $testParameterId, ')
          ..write('parameterName: $parameterName, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $DoctorsTable doctors = $DoctorsTable(this);
  late final $LabTestsTable labTests = $LabTestsTable(this);
  late final $TestParametersTable testParameters = $TestParametersTable(this);
  late final $PatientsTable patients = $PatientsTable(this);
  late final $PatientTestsTable patientTests = $PatientTestsTable(this);
  late final $TestReadingsTable testReadings = $TestReadingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettings,
    doctors,
    labTests,
    testParameters,
    patients,
    patientTests,
    testReadings,
  ];
}

typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> labCode,
      Value<String> licenseKey,
      Value<String> licenseVer,
      Value<String> labName,
      Value<bool> registered,
      Value<bool> securityEnabled,
      Value<String?> passwordHash,
      Value<String?> passwordSalt,
      Value<bool> importPromptDone,
      Value<DateTime?> registeredAt,
      Value<bool> showReportHeader,
      Value<bool> showReportFooter,
      Value<String> reportHeaderHtml,
      Value<String> reportFooterHtml,
      Value<int?> reportHeaderHeightMm,
      Value<int?> reportFooterHeightMm,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> labCode,
      Value<String> licenseKey,
      Value<String> licenseVer,
      Value<String> labName,
      Value<bool> registered,
      Value<bool> securityEnabled,
      Value<String?> passwordHash,
      Value<String?> passwordSalt,
      Value<bool> importPromptDone,
      Value<DateTime?> registeredAt,
      Value<bool> showReportHeader,
      Value<bool> showReportFooter,
      Value<String> reportHeaderHtml,
      Value<String> reportFooterHtml,
      Value<int?> reportHeaderHeightMm,
      Value<int?> reportFooterHeightMm,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labCode => $composableBuilder(
    column: $table.labCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseVer => $composableBuilder(
    column: $table.licenseVer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get securityEnabled => $composableBuilder(
    column: $table.securityEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get importPromptDone => $composableBuilder(
    column: $table.importPromptDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showReportHeader => $composableBuilder(
    column: $table.showReportHeader,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showReportFooter => $composableBuilder(
    column: $table.showReportFooter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportHeaderHtml => $composableBuilder(
    column: $table.reportHeaderHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportFooterHtml => $composableBuilder(
    column: $table.reportFooterHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportHeaderHeightMm => $composableBuilder(
    column: $table.reportHeaderHeightMm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reportFooterHeightMm => $composableBuilder(
    column: $table.reportFooterHeightMm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labCode => $composableBuilder(
    column: $table.labCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseVer => $composableBuilder(
    column: $table.licenseVer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get securityEnabled => $composableBuilder(
    column: $table.securityEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get importPromptDone => $composableBuilder(
    column: $table.importPromptDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showReportHeader => $composableBuilder(
    column: $table.showReportHeader,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showReportFooter => $composableBuilder(
    column: $table.showReportFooter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportHeaderHtml => $composableBuilder(
    column: $table.reportHeaderHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportFooterHtml => $composableBuilder(
    column: $table.reportFooterHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportHeaderHeightMm => $composableBuilder(
    column: $table.reportHeaderHeightMm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reportFooterHeightMm => $composableBuilder(
    column: $table.reportFooterHeightMm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get labCode =>
      $composableBuilder(column: $table.labCode, builder: (column) => column);

  GeneratedColumn<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenseVer => $composableBuilder(
    column: $table.licenseVer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labName =>
      $composableBuilder(column: $table.labName, builder: (column) => column);

  GeneratedColumn<bool> get registered => $composableBuilder(
    column: $table.registered,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get securityEnabled => $composableBuilder(
    column: $table.securityEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get importPromptDone => $composableBuilder(
    column: $table.importPromptDone,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showReportHeader => $composableBuilder(
    column: $table.showReportHeader,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showReportFooter => $composableBuilder(
    column: $table.showReportFooter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportHeaderHtml => $composableBuilder(
    column: $table.reportHeaderHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportFooterHtml => $composableBuilder(
    column: $table.reportFooterHtml,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reportHeaderHeightMm => $composableBuilder(
    column: $table.reportHeaderHeightMm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reportFooterHeightMm => $composableBuilder(
    column: $table.reportFooterHeightMm,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> labCode = const Value.absent(),
                Value<String> licenseKey = const Value.absent(),
                Value<String> licenseVer = const Value.absent(),
                Value<String> labName = const Value.absent(),
                Value<bool> registered = const Value.absent(),
                Value<bool> securityEnabled = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<bool> importPromptDone = const Value.absent(),
                Value<DateTime?> registeredAt = const Value.absent(),
                Value<bool> showReportHeader = const Value.absent(),
                Value<bool> showReportFooter = const Value.absent(),
                Value<String> reportHeaderHtml = const Value.absent(),
                Value<String> reportFooterHtml = const Value.absent(),
                Value<int?> reportHeaderHeightMm = const Value.absent(),
                Value<int?> reportFooterHeightMm = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                labCode: labCode,
                licenseKey: licenseKey,
                licenseVer: licenseVer,
                labName: labName,
                registered: registered,
                securityEnabled: securityEnabled,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                importPromptDone: importPromptDone,
                registeredAt: registeredAt,
                showReportHeader: showReportHeader,
                showReportFooter: showReportFooter,
                reportHeaderHtml: reportHeaderHtml,
                reportFooterHtml: reportFooterHtml,
                reportHeaderHeightMm: reportHeaderHeightMm,
                reportFooterHeightMm: reportFooterHeightMm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> labCode = const Value.absent(),
                Value<String> licenseKey = const Value.absent(),
                Value<String> licenseVer = const Value.absent(),
                Value<String> labName = const Value.absent(),
                Value<bool> registered = const Value.absent(),
                Value<bool> securityEnabled = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<bool> importPromptDone = const Value.absent(),
                Value<DateTime?> registeredAt = const Value.absent(),
                Value<bool> showReportHeader = const Value.absent(),
                Value<bool> showReportFooter = const Value.absent(),
                Value<String> reportHeaderHtml = const Value.absent(),
                Value<String> reportFooterHtml = const Value.absent(),
                Value<int?> reportHeaderHeightMm = const Value.absent(),
                Value<int?> reportFooterHeightMm = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                labCode: labCode,
                licenseKey: licenseKey,
                licenseVer: licenseVer,
                labName: labName,
                registered: registered,
                securityEnabled: securityEnabled,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                importPromptDone: importPromptDone,
                registeredAt: registeredAt,
                showReportHeader: showReportHeader,
                showReportFooter: showReportFooter,
                reportHeaderHtml: reportHeaderHtml,
                reportFooterHtml: reportFooterHtml,
                reportHeaderHeightMm: reportHeaderHeightMm,
                reportFooterHeightMm: reportFooterHeightMm,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$DoctorsTableCreateCompanionBuilder =
    DoctorsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> org,
      Value<String> email,
      Value<String> phone,
      Value<String> address,
      Value<double> commissionPercent,
      Value<double> wallet,
      Value<bool> isInternal,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });
typedef $$DoctorsTableUpdateCompanionBuilder =
    DoctorsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> org,
      Value<String> email,
      Value<String> phone,
      Value<String> address,
      Value<double> commissionPercent,
      Value<double> wallet,
      Value<bool> isInternal,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });

final class $$DoctorsTableReferences
    extends BaseReferences<_$AppDatabase, $DoctorsTable, Doctor> {
  $$DoctorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PatientsTable, List<Patient>> _patientsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.patients,
    aliasName: $_aliasNameGenerator(db.doctors.id, db.patients.doctorId),
  );

  $$PatientsTableProcessedTableManager get patientsRefs {
    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.doctorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_patientsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DoctorsTableFilterComposer
    extends Composer<_$AppDatabase, $DoctorsTable> {
  $$DoctorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get org => $composableBuilder(
    column: $table.org,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wallet => $composableBuilder(
    column: $table.wallet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInternal => $composableBuilder(
    column: $table.isInternal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> patientsRefs(
    Expression<bool> Function($$PatientsTableFilterComposer f) f,
  ) {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.doctorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DoctorsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoctorsTable> {
  $$DoctorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get org => $composableBuilder(
    column: $table.org,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wallet => $composableBuilder(
    column: $table.wallet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInternal => $composableBuilder(
    column: $table.isInternal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoctorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoctorsTable> {
  $$DoctorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get org =>
      $composableBuilder(column: $table.org, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wallet =>
      $composableBuilder(column: $table.wallet, builder: (column) => column);

  GeneratedColumn<bool> get isInternal => $composableBuilder(
    column: $table.isInternal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> patientsRefs<T extends Object>(
    Expression<T> Function($$PatientsTableAnnotationComposer a) f,
  ) {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.doctorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DoctorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoctorsTable,
          Doctor,
          $$DoctorsTableFilterComposer,
          $$DoctorsTableOrderingComposer,
          $$DoctorsTableAnnotationComposer,
          $$DoctorsTableCreateCompanionBuilder,
          $$DoctorsTableUpdateCompanionBuilder,
          (Doctor, $$DoctorsTableReferences),
          Doctor,
          PrefetchHooks Function({bool patientsRefs})
        > {
  $$DoctorsTableTableManager(_$AppDatabase db, $DoctorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoctorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoctorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoctorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> org = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<double> wallet = const Value.absent(),
                Value<bool> isInternal = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DoctorsCompanion(
                id: id,
                name: name,
                org: org,
                email: email,
                phone: phone,
                address: address,
                commissionPercent: commissionPercent,
                wallet: wallet,
                isInternal: isInternal,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> org = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<double> wallet = const Value.absent(),
                Value<bool> isInternal = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DoctorsCompanion.insert(
                id: id,
                name: name,
                org: org,
                email: email,
                phone: phone,
                address: address,
                commissionPercent: commissionPercent,
                wallet: wallet,
                isInternal: isInternal,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DoctorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (patientsRefs) db.patients],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (patientsRefs)
                    await $_getPrefetchedData<Doctor, $DoctorsTable, Patient>(
                      currentTable: table,
                      referencedTable: $$DoctorsTableReferences
                          ._patientsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DoctorsTableReferences(db, table, p0).patientsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.doctorId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DoctorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoctorsTable,
      Doctor,
      $$DoctorsTableFilterComposer,
      $$DoctorsTableOrderingComposer,
      $$DoctorsTableAnnotationComposer,
      $$DoctorsTableCreateCompanionBuilder,
      $$DoctorsTableUpdateCompanionBuilder,
      (Doctor, $$DoctorsTableReferences),
      Doctor,
      PrefetchHooks Function({bool patientsRefs})
    >;
typedef $$LabTestsTableCreateCompanionBuilder =
    LabTestsCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<String> department,
      Value<String> description,
      Value<double> price,
      Value<double> maxDisc,
      Value<double?> commissionPercent,
      Value<int> paramCount,
      Value<int?> masterTestId,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });
typedef $$LabTestsTableUpdateCompanionBuilder =
    LabTestsCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<String> department,
      Value<String> description,
      Value<double> price,
      Value<double> maxDisc,
      Value<double?> commissionPercent,
      Value<int> paramCount,
      Value<int?> masterTestId,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });

final class $$LabTestsTableReferences
    extends BaseReferences<_$AppDatabase, $LabTestsTable, LabTest> {
  $$LabTestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TestParametersTable, List<TestParameter>>
  _testParametersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testParameters,
    aliasName: $_aliasNameGenerator(db.labTests.id, db.testParameters.testId),
  );

  $$TestParametersTableProcessedTableManager get testParametersRefs {
    final manager = $$TestParametersTableTableManager(
      $_db,
      $_db.testParameters,
    ).filter((f) => f.testId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_testParametersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PatientTestsTable, List<PatientTest>>
  _patientTestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.patientTests,
    aliasName: $_aliasNameGenerator(db.labTests.id, db.patientTests.testId),
  );

  $$PatientTestsTableProcessedTableManager get patientTestsRefs {
    final manager = $$PatientTestsTableTableManager(
      $_db,
      $_db.patientTests,
    ).filter((f) => f.testId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_patientTestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LabTestsTableFilterComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxDisc => $composableBuilder(
    column: $table.maxDisc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paramCount => $composableBuilder(
    column: $table.paramCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get masterTestId => $composableBuilder(
    column: $table.masterTestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> testParametersRefs(
    Expression<bool> Function($$TestParametersTableFilterComposer f) f,
  ) {
    final $$TestParametersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testParameters,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestParametersTableFilterComposer(
            $db: $db,
            $table: $db.testParameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> patientTestsRefs(
    Expression<bool> Function($$PatientTestsTableFilterComposer f) f,
  ) {
    final $$PatientTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableFilterComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LabTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxDisc => $composableBuilder(
    column: $table.maxDisc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paramCount => $composableBuilder(
    column: $table.paramCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get masterTestId => $composableBuilder(
    column: $table.masterTestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabTestsTable> {
  $$LabTestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get maxDisc =>
      $composableBuilder(column: $table.maxDisc, builder: (column) => column);

  GeneratedColumn<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paramCount => $composableBuilder(
    column: $table.paramCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get masterTestId => $composableBuilder(
    column: $table.masterTestId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> testParametersRefs<T extends Object>(
    Expression<T> Function($$TestParametersTableAnnotationComposer a) f,
  ) {
    final $$TestParametersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testParameters,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestParametersTableAnnotationComposer(
            $db: $db,
            $table: $db.testParameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> patientTestsRefs<T extends Object>(
    Expression<T> Function($$PatientTestsTableAnnotationComposer a) f,
  ) {
    final $$PatientTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LabTestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LabTestsTable,
          LabTest,
          $$LabTestsTableFilterComposer,
          $$LabTestsTableOrderingComposer,
          $$LabTestsTableAnnotationComposer,
          $$LabTestsTableCreateCompanionBuilder,
          $$LabTestsTableUpdateCompanionBuilder,
          (LabTest, $$LabTestsTableReferences),
          LabTest,
          PrefetchHooks Function({
            bool testParametersRefs,
            bool patientTestsRefs,
          })
        > {
  $$LabTestsTableTableManager(_$AppDatabase db, $LabTestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> maxDisc = const Value.absent(),
                Value<double?> commissionPercent = const Value.absent(),
                Value<int> paramCount = const Value.absent(),
                Value<int?> masterTestId = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LabTestsCompanion(
                id: id,
                code: code,
                name: name,
                department: department,
                description: description,
                price: price,
                maxDisc: maxDisc,
                commissionPercent: commissionPercent,
                paramCount: paramCount,
                masterTestId: masterTestId,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<String> department = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> maxDisc = const Value.absent(),
                Value<double?> commissionPercent = const Value.absent(),
                Value<int> paramCount = const Value.absent(),
                Value<int?> masterTestId = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LabTestsCompanion.insert(
                id: id,
                code: code,
                name: name,
                department: department,
                description: description,
                price: price,
                maxDisc: maxDisc,
                commissionPercent: commissionPercent,
                paramCount: paramCount,
                masterTestId: masterTestId,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LabTestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({testParametersRefs = false, patientTestsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (testParametersRefs) db.testParameters,
                    if (patientTestsRefs) db.patientTests,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (testParametersRefs)
                        await $_getPrefetchedData<
                          LabTest,
                          $LabTestsTable,
                          TestParameter
                        >(
                          currentTable: table,
                          referencedTable: $$LabTestsTableReferences
                              ._testParametersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LabTestsTableReferences(
                                db,
                                table,
                                p0,
                              ).testParametersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.testId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (patientTestsRefs)
                        await $_getPrefetchedData<
                          LabTest,
                          $LabTestsTable,
                          PatientTest
                        >(
                          currentTable: table,
                          referencedTable: $$LabTestsTableReferences
                              ._patientTestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LabTestsTableReferences(
                                db,
                                table,
                                p0,
                              ).patientTestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.testId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LabTestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LabTestsTable,
      LabTest,
      $$LabTestsTableFilterComposer,
      $$LabTestsTableOrderingComposer,
      $$LabTestsTableAnnotationComposer,
      $$LabTestsTableCreateCompanionBuilder,
      $$LabTestsTableUpdateCompanionBuilder,
      (LabTest, $$LabTestsTableReferences),
      LabTest,
      PrefetchHooks Function({bool testParametersRefs, bool patientTestsRefs})
    >;
typedef $$TestParametersTableCreateCompanionBuilder =
    TestParametersCompanion Function({
      Value<int> id,
      required int testId,
      required String title,
      Value<String> unit,
      Value<String> valueType,
      Value<String> formula,
      Value<String> maleRange,
      Value<String> femaleRange,
      Value<int> sortOrder,
      Value<String?> sectionTitle,
      Value<double?> groupSumEquals,
      Value<int?> masterParameterId,
      Value<bool> deleteStatus,
    });
typedef $$TestParametersTableUpdateCompanionBuilder =
    TestParametersCompanion Function({
      Value<int> id,
      Value<int> testId,
      Value<String> title,
      Value<String> unit,
      Value<String> valueType,
      Value<String> formula,
      Value<String> maleRange,
      Value<String> femaleRange,
      Value<int> sortOrder,
      Value<String?> sectionTitle,
      Value<double?> groupSumEquals,
      Value<int?> masterParameterId,
      Value<bool> deleteStatus,
    });

final class $$TestParametersTableReferences
    extends BaseReferences<_$AppDatabase, $TestParametersTable, TestParameter> {
  $$TestParametersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LabTestsTable _testIdTable(_$AppDatabase db) =>
      db.labTests.createAlias(
        $_aliasNameGenerator(db.testParameters.testId, db.labTests.id),
      );

  $$LabTestsTableProcessedTableManager get testId {
    final $_column = $_itemColumn<int>('test_id')!;

    final manager = $$LabTestsTableTableManager(
      $_db,
      $_db.labTests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TestReadingsTable, List<TestReading>>
  _testReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testReadings,
    aliasName: $_aliasNameGenerator(
      db.testParameters.id,
      db.testReadings.testParameterId,
    ),
  );

  $$TestReadingsTableProcessedTableManager get testReadingsRefs {
    final manager = $$TestReadingsTableTableManager(
      $_db,
      $_db.testReadings,
    ).filter((f) => f.testParameterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_testReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TestParametersTableFilterComposer
    extends Composer<_$AppDatabase, $TestParametersTable> {
  $$TestParametersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formula => $composableBuilder(
    column: $table.formula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maleRange => $composableBuilder(
    column: $table.maleRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get femaleRange => $composableBuilder(
    column: $table.femaleRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sectionTitle => $composableBuilder(
    column: $table.sectionTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get groupSumEquals => $composableBuilder(
    column: $table.groupSumEquals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get masterParameterId => $composableBuilder(
    column: $table.masterParameterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LabTestsTableFilterComposer get testId {
    final $$LabTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableFilterComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> testReadingsRefs(
    Expression<bool> Function($$TestReadingsTableFilterComposer f) f,
  ) {
    final $$TestReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.testParameterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableFilterComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TestParametersTableOrderingComposer
    extends Composer<_$AppDatabase, $TestParametersTable> {
  $$TestParametersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueType => $composableBuilder(
    column: $table.valueType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formula => $composableBuilder(
    column: $table.formula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maleRange => $composableBuilder(
    column: $table.maleRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get femaleRange => $composableBuilder(
    column: $table.femaleRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sectionTitle => $composableBuilder(
    column: $table.sectionTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get groupSumEquals => $composableBuilder(
    column: $table.groupSumEquals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get masterParameterId => $composableBuilder(
    column: $table.masterParameterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LabTestsTableOrderingComposer get testId {
    final $$LabTestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableOrderingComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestParametersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestParametersTable> {
  $$TestParametersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get valueType =>
      $composableBuilder(column: $table.valueType, builder: (column) => column);

  GeneratedColumn<String> get formula =>
      $composableBuilder(column: $table.formula, builder: (column) => column);

  GeneratedColumn<String> get maleRange =>
      $composableBuilder(column: $table.maleRange, builder: (column) => column);

  GeneratedColumn<String> get femaleRange => $composableBuilder(
    column: $table.femaleRange,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get sectionTitle => $composableBuilder(
    column: $table.sectionTitle,
    builder: (column) => column,
  );

  GeneratedColumn<double> get groupSumEquals => $composableBuilder(
    column: $table.groupSumEquals,
    builder: (column) => column,
  );

  GeneratedColumn<int> get masterParameterId => $composableBuilder(
    column: $table.masterParameterId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => column,
  );

  $$LabTestsTableAnnotationComposer get testId {
    final $$LabTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> testReadingsRefs<T extends Object>(
    Expression<T> Function($$TestReadingsTableAnnotationComposer a) f,
  ) {
    final $$TestReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.testParameterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TestParametersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TestParametersTable,
          TestParameter,
          $$TestParametersTableFilterComposer,
          $$TestParametersTableOrderingComposer,
          $$TestParametersTableAnnotationComposer,
          $$TestParametersTableCreateCompanionBuilder,
          $$TestParametersTableUpdateCompanionBuilder,
          (TestParameter, $$TestParametersTableReferences),
          TestParameter,
          PrefetchHooks Function({bool testId, bool testReadingsRefs})
        > {
  $$TestParametersTableTableManager(
    _$AppDatabase db,
    $TestParametersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestParametersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestParametersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestParametersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> testId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<String> formula = const Value.absent(),
                Value<String> maleRange = const Value.absent(),
                Value<String> femaleRange = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> sectionTitle = const Value.absent(),
                Value<double?> groupSumEquals = const Value.absent(),
                Value<int?> masterParameterId = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
              }) => TestParametersCompanion(
                id: id,
                testId: testId,
                title: title,
                unit: unit,
                valueType: valueType,
                formula: formula,
                maleRange: maleRange,
                femaleRange: femaleRange,
                sortOrder: sortOrder,
                sectionTitle: sectionTitle,
                groupSumEquals: groupSumEquals,
                masterParameterId: masterParameterId,
                deleteStatus: deleteStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int testId,
                required String title,
                Value<String> unit = const Value.absent(),
                Value<String> valueType = const Value.absent(),
                Value<String> formula = const Value.absent(),
                Value<String> maleRange = const Value.absent(),
                Value<String> femaleRange = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> sectionTitle = const Value.absent(),
                Value<double?> groupSumEquals = const Value.absent(),
                Value<int?> masterParameterId = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
              }) => TestParametersCompanion.insert(
                id: id,
                testId: testId,
                title: title,
                unit: unit,
                valueType: valueType,
                formula: formula,
                maleRange: maleRange,
                femaleRange: femaleRange,
                sortOrder: sortOrder,
                sectionTitle: sectionTitle,
                groupSumEquals: groupSumEquals,
                masterParameterId: masterParameterId,
                deleteStatus: deleteStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TestParametersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({testId = false, testReadingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (testReadingsRefs) db.testReadings],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (testId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.testId,
                                referencedTable: $$TestParametersTableReferences
                                    ._testIdTable(db),
                                referencedColumn:
                                    $$TestParametersTableReferences
                                        ._testIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (testReadingsRefs)
                    await $_getPrefetchedData<
                      TestParameter,
                      $TestParametersTable,
                      TestReading
                    >(
                      currentTable: table,
                      referencedTable: $$TestParametersTableReferences
                          ._testReadingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TestParametersTableReferences(
                            db,
                            table,
                            p0,
                          ).testReadingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.testParameterId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TestParametersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TestParametersTable,
      TestParameter,
      $$TestParametersTableFilterComposer,
      $$TestParametersTableOrderingComposer,
      $$TestParametersTableAnnotationComposer,
      $$TestParametersTableCreateCompanionBuilder,
      $$TestParametersTableUpdateCompanionBuilder,
      (TestParameter, $$TestParametersTableReferences),
      TestParameter,
      PrefetchHooks Function({bool testId, bool testReadingsRefs})
    >;
typedef $$PatientsTableCreateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      Value<String> prefix,
      required String firstName,
      Value<String> lastName,
      Value<int?> age,
      Value<String> sex,
      Value<String> phone,
      Value<String> email,
      Value<String> address,
      Value<int?> doctorId,
      Value<String> referredBy,
      Value<double> totalAmount,
      Value<double> discountAmount,
      Value<double> discountPercent,
      Value<double> payableAmount,
      Value<double> paidAmount,
      Value<String> paymentMethod,
      Value<String> remark,
      Value<String> status,
      Value<DateTime?> approvedAt,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });
typedef $$PatientsTableUpdateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      Value<String> prefix,
      Value<String> firstName,
      Value<String> lastName,
      Value<int?> age,
      Value<String> sex,
      Value<String> phone,
      Value<String> email,
      Value<String> address,
      Value<int?> doctorId,
      Value<String> referredBy,
      Value<double> totalAmount,
      Value<double> discountAmount,
      Value<double> discountPercent,
      Value<double> payableAmount,
      Value<double> paidAmount,
      Value<String> paymentMethod,
      Value<String> remark,
      Value<String> status,
      Value<DateTime?> approvedAt,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });

final class $$PatientsTableReferences
    extends BaseReferences<_$AppDatabase, $PatientsTable, Patient> {
  $$PatientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DoctorsTable _doctorIdTable(_$AppDatabase db) => db.doctors
      .createAlias($_aliasNameGenerator(db.patients.doctorId, db.doctors.id));

  $$DoctorsTableProcessedTableManager? get doctorId {
    final $_column = $_itemColumn<int>('doctor_id');
    if ($_column == null) return null;
    final manager = $$DoctorsTableTableManager(
      $_db,
      $_db.doctors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_doctorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PatientTestsTable, List<PatientTest>>
  _patientTestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.patientTests,
    aliasName: $_aliasNameGenerator(db.patients.id, db.patientTests.patientId),
  );

  $$PatientTestsTableProcessedTableManager get patientTestsRefs {
    final manager = $$PatientTestsTableTableManager(
      $_db,
      $_db.patientTests,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_patientTestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TestReadingsTable, List<TestReading>>
  _testReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testReadings,
    aliasName: $_aliasNameGenerator(db.patients.id, db.testReadings.patientId),
  );

  $$TestReadingsTableProcessedTableManager get testReadingsRefs {
    final manager = $$TestReadingsTableTableManager(
      $_db,
      $_db.testReadings,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_testReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get payableAmount => $composableBuilder(
    column: $table.payableAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DoctorsTableFilterComposer get doctorId {
    final $$DoctorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doctorId,
      referencedTable: $db.doctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoctorsTableFilterComposer(
            $db: $db,
            $table: $db.doctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> patientTestsRefs(
    Expression<bool> Function($$PatientTestsTableFilterComposer f) f,
  ) {
    final $$PatientTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableFilterComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> testReadingsRefs(
    Expression<bool> Function($$TestReadingsTableFilterComposer f) f,
  ) {
    final $$TestReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableFilterComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get payableAmount => $composableBuilder(
    column: $table.payableAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DoctorsTableOrderingComposer get doctorId {
    final $$DoctorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doctorId,
      referencedTable: $db.doctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoctorsTableOrderingComposer(
            $db: $db,
            $table: $db.doctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prefix =>
      $composableBuilder(column: $table.prefix, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get referredBy => $composableBuilder(
    column: $table.referredBy,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get payableAmount => $composableBuilder(
    column: $table.payableAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DoctorsTableAnnotationComposer get doctorId {
    final $$DoctorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doctorId,
      referencedTable: $db.doctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoctorsTableAnnotationComposer(
            $db: $db,
            $table: $db.doctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> patientTestsRefs<T extends Object>(
    Expression<T> Function($$PatientTestsTableAnnotationComposer a) f,
  ) {
    final $$PatientTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> testReadingsRefs<T extends Object>(
    Expression<T> Function($$TestReadingsTableAnnotationComposer a) f,
  ) {
    final $$TestReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientsTable,
          Patient,
          $$PatientsTableFilterComposer,
          $$PatientsTableOrderingComposer,
          $$PatientsTableAnnotationComposer,
          $$PatientsTableCreateCompanionBuilder,
          $$PatientsTableUpdateCompanionBuilder,
          (Patient, $$PatientsTableReferences),
          Patient,
          PrefetchHooks Function({
            bool doctorId,
            bool patientTestsRefs,
            bool testReadingsRefs,
          })
        > {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prefix = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int?> doctorId = const Value.absent(),
                Value<String> referredBy = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> payableAmount = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> remark = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PatientsCompanion(
                id: id,
                prefix: prefix,
                firstName: firstName,
                lastName: lastName,
                age: age,
                sex: sex,
                phone: phone,
                email: email,
                address: address,
                doctorId: doctorId,
                referredBy: referredBy,
                totalAmount: totalAmount,
                discountAmount: discountAmount,
                discountPercent: discountPercent,
                payableAmount: payableAmount,
                paidAmount: paidAmount,
                paymentMethod: paymentMethod,
                remark: remark,
                status: status,
                approvedAt: approvedAt,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prefix = const Value.absent(),
                required String firstName,
                Value<String> lastName = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int?> doctorId = const Value.absent(),
                Value<String> referredBy = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> payableAmount = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> remark = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PatientsCompanion.insert(
                id: id,
                prefix: prefix,
                firstName: firstName,
                lastName: lastName,
                age: age,
                sex: sex,
                phone: phone,
                email: email,
                address: address,
                doctorId: doctorId,
                referredBy: referredBy,
                totalAmount: totalAmount,
                discountAmount: discountAmount,
                discountPercent: discountPercent,
                payableAmount: payableAmount,
                paidAmount: paidAmount,
                paymentMethod: paymentMethod,
                remark: remark,
                status: status,
                approvedAt: approvedAt,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PatientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                doctorId = false,
                patientTestsRefs = false,
                testReadingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (patientTestsRefs) db.patientTests,
                    if (testReadingsRefs) db.testReadings,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (doctorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.doctorId,
                                    referencedTable: $$PatientsTableReferences
                                        ._doctorIdTable(db),
                                    referencedColumn: $$PatientsTableReferences
                                        ._doctorIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (patientTestsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          PatientTest
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._patientTestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).patientTestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (testReadingsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          TestReading
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._testReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).testReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PatientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientsTable,
      Patient,
      $$PatientsTableFilterComposer,
      $$PatientsTableOrderingComposer,
      $$PatientsTableAnnotationComposer,
      $$PatientsTableCreateCompanionBuilder,
      $$PatientsTableUpdateCompanionBuilder,
      (Patient, $$PatientsTableReferences),
      Patient,
      PrefetchHooks Function({
        bool doctorId,
        bool patientTestsRefs,
        bool testReadingsRefs,
      })
    >;
typedef $$PatientTestsTableCreateCompanionBuilder =
    PatientTestsCompanion Function({
      Value<int> id,
      required int patientId,
      required int testId,
      Value<double> price,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });
typedef $$PatientTestsTableUpdateCompanionBuilder =
    PatientTestsCompanion Function({
      Value<int> id,
      Value<int> patientId,
      Value<int> testId,
      Value<double> price,
      Value<bool> deleteStatus,
      Value<DateTime> createdAt,
    });

final class $$PatientTestsTableReferences
    extends BaseReferences<_$AppDatabase, $PatientTestsTable, PatientTest> {
  $$PatientTestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.patientTests.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<int>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LabTestsTable _testIdTable(_$AppDatabase db) =>
      db.labTests.createAlias(
        $_aliasNameGenerator(db.patientTests.testId, db.labTests.id),
      );

  $$LabTestsTableProcessedTableManager get testId {
    final $_column = $_itemColumn<int>('test_id')!;

    final manager = $$LabTestsTableTableManager(
      $_db,
      $_db.labTests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TestReadingsTable, List<TestReading>>
  _testReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.testReadings,
    aliasName: $_aliasNameGenerator(
      db.patientTests.id,
      db.testReadings.patientTestId,
    ),
  );

  $$TestReadingsTableProcessedTableManager get testReadingsRefs {
    final manager = $$TestReadingsTableTableManager(
      $_db,
      $_db.testReadings,
    ).filter((f) => f.patientTestId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_testReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PatientTestsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientTestsTable> {
  $$PatientTestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LabTestsTableFilterComposer get testId {
    final $$LabTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableFilterComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> testReadingsRefs(
    Expression<bool> Function($$TestReadingsTableFilterComposer f) f,
  ) {
    final $$TestReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.patientTestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableFilterComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientTestsTable> {
  $$PatientTestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LabTestsTableOrderingComposer get testId {
    final $$LabTestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableOrderingComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatientTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientTestsTable> {
  $$PatientTestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<bool> get deleteStatus => $composableBuilder(
    column: $table.deleteStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LabTestsTableAnnotationComposer get testId {
    final $$LabTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.labTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LabTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.labTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> testReadingsRefs<T extends Object>(
    Expression<T> Function($$TestReadingsTableAnnotationComposer a) f,
  ) {
    final $$TestReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.testReadings,
      getReferencedColumn: (t) => t.patientTestId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.testReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PatientTestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientTestsTable,
          PatientTest,
          $$PatientTestsTableFilterComposer,
          $$PatientTestsTableOrderingComposer,
          $$PatientTestsTableAnnotationComposer,
          $$PatientTestsTableCreateCompanionBuilder,
          $$PatientTestsTableUpdateCompanionBuilder,
          (PatientTest, $$PatientTestsTableReferences),
          PatientTest,
          PrefetchHooks Function({
            bool patientId,
            bool testId,
            bool testReadingsRefs,
          })
        > {
  $$PatientTestsTableTableManager(_$AppDatabase db, $PatientTestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> patientId = const Value.absent(),
                Value<int> testId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PatientTestsCompanion(
                id: id,
                patientId: patientId,
                testId: testId,
                price: price,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int patientId,
                required int testId,
                Value<double> price = const Value.absent(),
                Value<bool> deleteStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PatientTestsCompanion.insert(
                id: id,
                patientId: patientId,
                testId: testId,
                price: price,
                deleteStatus: deleteStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PatientTestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({patientId = false, testId = false, testReadingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (testReadingsRefs) db.testReadings,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (patientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.patientId,
                                    referencedTable:
                                        $$PatientTestsTableReferences
                                            ._patientIdTable(db),
                                    referencedColumn:
                                        $$PatientTestsTableReferences
                                            ._patientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (testId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.testId,
                                    referencedTable:
                                        $$PatientTestsTableReferences
                                            ._testIdTable(db),
                                    referencedColumn:
                                        $$PatientTestsTableReferences
                                            ._testIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (testReadingsRefs)
                        await $_getPrefetchedData<
                          PatientTest,
                          $PatientTestsTable,
                          TestReading
                        >(
                          currentTable: table,
                          referencedTable: $$PatientTestsTableReferences
                              ._testReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientTestsTableReferences(
                                db,
                                table,
                                p0,
                              ).testReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientTestId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PatientTestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientTestsTable,
      PatientTest,
      $$PatientTestsTableFilterComposer,
      $$PatientTestsTableOrderingComposer,
      $$PatientTestsTableAnnotationComposer,
      $$PatientTestsTableCreateCompanionBuilder,
      $$PatientTestsTableUpdateCompanionBuilder,
      (PatientTest, $$PatientTestsTableReferences),
      PatientTest,
      PrefetchHooks Function({
        bool patientId,
        bool testId,
        bool testReadingsRefs,
      })
    >;
typedef $$TestReadingsTableCreateCompanionBuilder =
    TestReadingsCompanion Function({
      Value<int> id,
      required int patientId,
      Value<int?> patientTestId,
      Value<int?> testParameterId,
      required String parameterName,
      Value<String> value,
      Value<String> unit,
      Value<DateTime> updatedAt,
    });
typedef $$TestReadingsTableUpdateCompanionBuilder =
    TestReadingsCompanion Function({
      Value<int> id,
      Value<int> patientId,
      Value<int?> patientTestId,
      Value<int?> testParameterId,
      Value<String> parameterName,
      Value<String> value,
      Value<String> unit,
      Value<DateTime> updatedAt,
    });

final class $$TestReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $TestReadingsTable, TestReading> {
  $$TestReadingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.testReadings.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<int>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PatientTestsTable _patientTestIdTable(_$AppDatabase db) =>
      db.patientTests.createAlias(
        $_aliasNameGenerator(db.testReadings.patientTestId, db.patientTests.id),
      );

  $$PatientTestsTableProcessedTableManager? get patientTestId {
    final $_column = $_itemColumn<int>('patient_test_id');
    if ($_column == null) return null;
    final manager = $$PatientTestsTableTableManager(
      $_db,
      $_db.patientTests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientTestIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TestParametersTable _testParameterIdTable(_$AppDatabase db) =>
      db.testParameters.createAlias(
        $_aliasNameGenerator(
          db.testReadings.testParameterId,
          db.testParameters.id,
        ),
      );

  $$TestParametersTableProcessedTableManager? get testParameterId {
    final $_column = $_itemColumn<int>('test_parameter_id');
    if ($_column == null) return null;
    final manager = $$TestParametersTableTableManager(
      $_db,
      $_db.testParameters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testParameterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TestReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $TestReadingsTable> {
  $$TestReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parameterName => $composableBuilder(
    column: $table.parameterName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PatientTestsTableFilterComposer get patientTestId {
    final $$PatientTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientTestId,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableFilterComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TestParametersTableFilterComposer get testParameterId {
    final $$TestParametersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testParameterId,
      referencedTable: $db.testParameters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestParametersTableFilterComposer(
            $db: $db,
            $table: $db.testParameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $TestReadingsTable> {
  $$TestReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parameterName => $composableBuilder(
    column: $table.parameterName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PatientTestsTableOrderingComposer get patientTestId {
    final $$PatientTestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientTestId,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableOrderingComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TestParametersTableOrderingComposer get testParameterId {
    final $$TestParametersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testParameterId,
      referencedTable: $db.testParameters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestParametersTableOrderingComposer(
            $db: $db,
            $table: $db.testParameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TestReadingsTable> {
  $$TestReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parameterName => $composableBuilder(
    column: $table.parameterName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PatientTestsTableAnnotationComposer get patientTestId {
    final $$PatientTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientTestId,
      referencedTable: $db.patientTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.patientTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TestParametersTableAnnotationComposer get testParameterId {
    final $$TestParametersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testParameterId,
      referencedTable: $db.testParameters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TestParametersTableAnnotationComposer(
            $db: $db,
            $table: $db.testParameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TestReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TestReadingsTable,
          TestReading,
          $$TestReadingsTableFilterComposer,
          $$TestReadingsTableOrderingComposer,
          $$TestReadingsTableAnnotationComposer,
          $$TestReadingsTableCreateCompanionBuilder,
          $$TestReadingsTableUpdateCompanionBuilder,
          (TestReading, $$TestReadingsTableReferences),
          TestReading,
          PrefetchHooks Function({
            bool patientId,
            bool patientTestId,
            bool testParameterId,
          })
        > {
  $$TestReadingsTableTableManager(_$AppDatabase db, $TestReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> patientId = const Value.absent(),
                Value<int?> patientTestId = const Value.absent(),
                Value<int?> testParameterId = const Value.absent(),
                Value<String> parameterName = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TestReadingsCompanion(
                id: id,
                patientId: patientId,
                patientTestId: patientTestId,
                testParameterId: testParameterId,
                parameterName: parameterName,
                value: value,
                unit: unit,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int patientId,
                Value<int?> patientTestId = const Value.absent(),
                Value<int?> testParameterId = const Value.absent(),
                required String parameterName,
                Value<String> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TestReadingsCompanion.insert(
                id: id,
                patientId: patientId,
                patientTestId: patientTestId,
                testParameterId: testParameterId,
                parameterName: parameterName,
                value: value,
                unit: unit,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TestReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                patientId = false,
                patientTestId = false,
                testParameterId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (patientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.patientId,
                                    referencedTable:
                                        $$TestReadingsTableReferences
                                            ._patientIdTable(db),
                                    referencedColumn:
                                        $$TestReadingsTableReferences
                                            ._patientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (patientTestId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.patientTestId,
                                    referencedTable:
                                        $$TestReadingsTableReferences
                                            ._patientTestIdTable(db),
                                    referencedColumn:
                                        $$TestReadingsTableReferences
                                            ._patientTestIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (testParameterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.testParameterId,
                                    referencedTable:
                                        $$TestReadingsTableReferences
                                            ._testParameterIdTable(db),
                                    referencedColumn:
                                        $$TestReadingsTableReferences
                                            ._testParameterIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TestReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TestReadingsTable,
      TestReading,
      $$TestReadingsTableFilterComposer,
      $$TestReadingsTableOrderingComposer,
      $$TestReadingsTableAnnotationComposer,
      $$TestReadingsTableCreateCompanionBuilder,
      $$TestReadingsTableUpdateCompanionBuilder,
      (TestReading, $$TestReadingsTableReferences),
      TestReading,
      PrefetchHooks Function({
        bool patientId,
        bool patientTestId,
        bool testParameterId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$DoctorsTableTableManager get doctors =>
      $$DoctorsTableTableManager(_db, _db.doctors);
  $$LabTestsTableTableManager get labTests =>
      $$LabTestsTableTableManager(_db, _db.labTests);
  $$TestParametersTableTableManager get testParameters =>
      $$TestParametersTableTableManager(_db, _db.testParameters);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$PatientTestsTableTableManager get patientTests =>
      $$PatientTestsTableTableManager(_db, _db.patientTests);
  $$TestReadingsTableTableManager get testReadings =>
      $$TestReadingsTableTableManager(_db, _db.testReadings);
}
