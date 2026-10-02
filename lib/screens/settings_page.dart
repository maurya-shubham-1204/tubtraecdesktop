import 'package:drift/drift.dart' show Value;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/page_scaffold.dart';
import 'package:tubtrace_desktop/widgets/ui_bits.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppSetting? _settings;
  bool _busy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    final s = await AppScope.of(context).auth.settings();
    if (mounted) setState(() => _settings = s);
  }

  Future<void> _saveProfile() async {
    final s = _settings;
    if (s == null) return;

    final labNameCtrl = TextEditingController(text: s.labName);
    final addressCtrl = TextEditingController(text: s.address);
    final contactCtrl = TextEditingController(text: s.contact);
    final emailCtrl = TextEditingController(text: s.email);
    final websiteCtrl = TextEditingController(text: s.websiteUrl);
    final extraCtrl = TextEditingController(text: s.additionalInfo);
    final commissionCtrl = TextEditingController(text: s.defaultDoctorCommissionPercent.toString());
    final logoPathCtrl = TextEditingController(text: s.logoPath);
    final messenger = ScaffoldMessenger.maybeOf(context);
    final db = AppScope.of(context).db;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lab profile'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: labNameCtrl, decoration: const InputDecoration(labelText: 'Lab name')),
                const SizedBox(height: 8),
                TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Address'), minLines: 2, maxLines: 3),
                const SizedBox(height: 8),
                TextField(controller: contactCtrl, decoration: const InputDecoration(labelText: 'Contact')),
                const SizedBox(height: 8),
                TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 8),
                TextField(controller: websiteCtrl, decoration: const InputDecoration(labelText: 'Website URL')),
                const SizedBox(height: 8),
                TextField(controller: extraCtrl, decoration: const InputDecoration(labelText: 'Additional info'), minLines: 2, maxLines: 4),
                const SizedBox(height: 8),
                TextField(
                  controller: commissionCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Default doctor commission %'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: logoPathCtrl,
                        readOnly: true,
                        decoration: const InputDecoration(labelText: 'Logo path'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () async {
                        final result = await FilePicker.pickFiles(type: FileType.image, allowMultiple: false);
                        if (result != null && result.files.single.path != null) {
                          logoPathCtrl.text = result.files.single.path!;
                        }
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Select'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (ok != true) {
      labNameCtrl.dispose();
      addressCtrl.dispose();
      contactCtrl.dispose();
      emailCtrl.dispose();
      websiteCtrl.dispose();
      extraCtrl.dispose();
      commissionCtrl.dispose();
      logoPathCtrl.dispose();
      return;
    }

    setState(() => _busy = true);
    try {
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        AppSettingsCompanion(
          labName: Value(labNameCtrl.text.trim()),
          address: Value(addressCtrl.text.trim()),
          contact: Value(contactCtrl.text.trim()),
          email: Value(emailCtrl.text.trim()),
          websiteUrl: Value(websiteCtrl.text.trim()),
          additionalInfo: Value(extraCtrl.text.trim()),
          logoPath: Value(logoPathCtrl.text.trim()),
          defaultDoctorCommissionPercent: Value(int.tryParse(commissionCtrl.text.trim()) ?? 0),
        ),
      );
      await _load();
      if (!mounted || messenger == null) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Lab profile saved')),
      );
    } catch (e) {
      if (!mounted || messenger == null) return;
      messenger.showSnackBar(SnackBar(content: Text('Profile save failed: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }

    labNameCtrl.dispose();
    addressCtrl.dispose();
    contactCtrl.dispose();
    emailCtrl.dispose();
    websiteCtrl.dispose();
    extraCtrl.dispose();
    commissionCtrl.dispose();
    logoPathCtrl.dispose();
  }

  Future<void> _export() async {
    setState(() => _busy = true);
    try {
      final path = await AppScope.of(context).backup.exportBackup();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            path == null
                ? 'Export cancelled'
                : 'Encrypted .tt saved (license key wrap). $path',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _import() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Replace local data?'),
        content: const Text(
          'Importing a .tt backup decrypts with the lab license key and replaces all data on this computer.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Continue')),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    final keyCtrl = TextEditingController(text: _settings?.licenseKey ?? '');
    final licenseKey = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('License key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter the registration license key that encrypted this .tt file.',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: keyCtrl,
              obscureText: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'License key',
                prefixIcon: Icon(Icons.vpn_key_outlined, size: 20),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, keyCtrl.text.trim()),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    keyCtrl.dispose();
    if (licenseKey == null || licenseKey.isEmpty || !mounted) return;

    setState(() => _busy = true);
    try {
      final scope = AppScope.of(context);
      final path = await scope.backup.pickImportFile();
      if (path == null) {
        setState(() => _busy = false);
        return;
      }
      await scope.backup.importBackup(backupPath: path, licenseKey: licenseKey);
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Encrypted backup imported successfully.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Import failed: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _toggleSecurity(bool enable) async {
    final scope = AppScope.of(context);
    if (!enable) {
      final pass = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Disable security'),
          content: TextField(
            controller: pass,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Current password'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Disable')),
          ],
        ),
      );
      if (ok != true) return;
      final valid = await scope.auth.verifyPassword(pass.text);
      pass.dispose();
      if (!valid) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
        return;
      }
      await scope.auth.setSecurity(enabled: false);
      await _load();
      return;
    }

    final pass = TextEditingController();
    final confirm = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable security'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New password'),
                validator: (v) => (v == null || v.length < 4) ? 'Min 4 chars' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: confirm,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm'),
                validator: (v) => v != pass.text ? 'Does not match' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) Navigator.pop(context, true);
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await scope.auth.setSecurity(enabled: true, password: pass.text);
      await _load();
    }
    pass.dispose();
    confirm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = _settings;
    return PageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionCard(
            title: 'Lab license',
            subtitle: 'Offline activation for this workstation',
            child: s == null
                ? const LinearProgressIndicator()
                : Column(
                    children: [
                      _InfoRow(label: 'Lab name', value: s.labName),
                      _InfoRow(label: 'Lab code', value: s.labCode),
                      _InfoRow(
                        label: 'Key',
                        value: '••••${s.licenseKey.length > 4 ? s.licenseKey.substring(s.licenseKey.length - 4) : ''}',
                      ),
                      _InfoRow(label: 'Version', value: s.licenseVer),
                      _InfoRow(
                        label: 'Registered',
                        value: s.registeredAt?.toLocal().toString().split('.').first ?? '—',
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 14),
          SectionCard(
            title: 'Security',
            subtitle: 'Lock screen password for this app',
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ask password on open'),
              subtitle: const Text('Protect this offline app on shared computers'),
              value: s?.securityEnabled ?? false,
              onChanged: _busy ? null : _toggleSecurity,
            ),
          ),
          const SizedBox(height: 14),
          SectionCard(
            title: 'Lab profile',
            subtitle: 'Match the web app details for the local lab record',
            child: s == null
                ? const LinearProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoRow(label: 'Lab name', value: s.labName),
                      _InfoRow(label: 'Address', value: s.address.isEmpty ? '—' : s.address),
                      _InfoRow(label: 'Contact', value: s.contact.isEmpty ? '—' : s.contact),
                      _InfoRow(label: 'Email', value: s.email.isEmpty ? '—' : s.email),
                      _InfoRow(label: 'Website', value: s.websiteUrl.isEmpty ? '—' : s.websiteUrl),
                      _InfoRow(label: 'Default doctor commission', value: '${s.defaultDoctorCommissionPercent}%'),
                      if (s.logoPath.isNotEmpty) _InfoRow(label: 'Logo', value: s.logoPath),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FilledButton.icon(
                          onPressed: _busy ? null : _saveProfile,
                          icon: const Icon(Icons.edit_note_outlined),
                          label: const Text('Edit lab profile'),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 14),
          SectionCard(
            title: 'Theme',
            subtitle: 'Accent color for sidebar, buttons and highlights',
            child: ListenableBuilder(
              listenable: AppThemeController.instance,
              builder: (context, _) {
                final selected = AppThemeController.instance.seed;
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final preset in ThemePresets.all)
                      _ThemeSwatch(
                        label: preset.$1,
                        color: preset.$2,
                        selected: selected.toARGB32() == preset.$2.toARGB32(),
                        onTap: () => AppThemeController.instance.setSeed(preset.$2),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          SectionCard(
            title: 'Report print',
            subtitle: 'Same as web lab settings (header / footer HTML + printable toggles)',
            child: s == null
                ? const LinearProgressIndicator()
                : _ReportPrintSettings(
                    settings: s,
                    busy: _busy,
                    onChanged: () => _load(),
                  ),
          ),
          const SizedBox(height: 14),
          SectionCard(
            title: 'Encrypted backup',
            subtitle: 'Export or restore a full lab backup file (.tt)',
            accent: AppColors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: _busy ? null : _export,
                      icon: const Icon(Icons.lock_outline),
                      label: const Text('Export .tt'),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: _busy ? null : _import,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Import .tt'),
                    ),
                    if (_busy) ...[
                      const SizedBox(width: 14),
                      const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionCard(
            title: 'Mode',
            subtitle: 'Connectivity',
            child: Text(
              'This build is offline-first. Online sync with TubTrace web will come later.',
              style: TextStyle(color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportPrintSettings extends StatefulWidget {
  const _ReportPrintSettings({
    required this.settings,
    required this.busy,
    required this.onChanged,
  });

  final AppSetting settings;
  final bool busy;
  final VoidCallback onChanged;

  @override
  State<_ReportPrintSettings> createState() => _ReportPrintSettingsState();
}

class _ReportPrintSettingsState extends State<_ReportPrintSettings> {
  late bool _showHeader = widget.settings.showReportHeader;
  late bool _showFooter = widget.settings.showReportFooter;
  late bool _showSectionTitles = widget.settings.showReportSectionTitles;
  late bool _colorInRange = widget.settings.reportColorInRange;
  late bool _colorOutOfRange = widget.settings.reportColorOutOfRange;
  late bool _flagLow = widget.settings.reportFlagLow;
  late bool _flagHigh = widget.settings.reportFlagHigh;
  late final _header = TextEditingController(text: widget.settings.reportHeaderHtml);
  late final _footer = TextEditingController(text: widget.settings.reportFooterHtml);
  late final _headerH = TextEditingController(
    text: widget.settings.reportHeaderHeightMm?.toString() ?? '',
  );
  late final _footerH = TextEditingController(
    text: widget.settings.reportFooterHeightMm?.toString() ?? '',
  );
  late final _patientFont = TextEditingController(
    text: (widget.settings.reportFontPatientPt ?? 9).toString(),
  );
  late final _testsFont = TextEditingController(
    text: (widget.settings.reportFontTestsPt ?? 9).toString(),
  );
  late final _descFont = TextEditingController(
    text: (widget.settings.reportFontDescriptionPt ?? 8).toString(),
  );
  bool _saving = false;

  @override
  void didUpdateWidget(covariant _ReportPrintSettings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.settings.id != widget.settings.id ||
        oldWidget.settings.showReportHeader != widget.settings.showReportHeader ||
        oldWidget.settings.reportHeaderHtml != widget.settings.reportHeaderHtml ||
        oldWidget.settings.reportFooterHtml != widget.settings.reportFooterHtml) {
      _showHeader = widget.settings.showReportHeader;
      _showFooter = widget.settings.showReportFooter;
      _showSectionTitles = widget.settings.showReportSectionTitles;
      _colorInRange = widget.settings.reportColorInRange;
      _colorOutOfRange = widget.settings.reportColorOutOfRange;
      _flagLow = widget.settings.reportFlagLow;
      _flagHigh = widget.settings.reportFlagHigh;
      _header.text = widget.settings.reportHeaderHtml;
      _footer.text = widget.settings.reportFooterHtml;
      _headerH.text = widget.settings.reportHeaderHeightMm?.toString() ?? '';
      _footerH.text = widget.settings.reportFooterHeightMm?.toString() ?? '';
      _patientFont.text = (widget.settings.reportFontPatientPt ?? 9).toString();
      _testsFont.text = (widget.settings.reportFontTestsPt ?? 9).toString();
      _descFont.text = (widget.settings.reportFontDescriptionPt ?? 8).toString();
    }
  }

  @override
  void dispose() {
    _header.dispose();
    _footer.dispose();
    _headerH.dispose();
    _footerH.dispose();
    _patientFont.dispose();
    _testsFont.dispose();
    _descFont.dispose();
    super.dispose();
  }

  int? _parseMm(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    return int.tryParse(t);
  }

  int _parseFont(String raw, int fallback) {
    final v = int.tryParse(raw.trim());
    if (v == null) return fallback;
    return v.clamp(6, 24);
  }

  Future<void> _save({bool quiet = false}) async {
    setState(() => _saving = true);
    try {
      final db = AppScope.of(context).db;
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        AppSettingsCompanion(
          showReportHeader: Value(_showHeader),
          showReportFooter: Value(_showFooter),
          showReportSectionTitles: Value(_showSectionTitles),
          reportColorInRange: Value(_colorInRange),
          reportColorOutOfRange: Value(_colorOutOfRange),
          reportFlagLow: Value(_flagLow),
          reportFlagHigh: Value(_flagHigh),
          reportFontPatientPt: Value(_parseFont(_patientFont.text, 9)),
          reportFontTestsPt: Value(_parseFont(_testsFont.text, 9)),
          reportFontDescriptionPt: Value(_parseFont(_descFont.text, 8)),
          reportHeaderHtml: Value(_header.text),
          reportFooterHtml: Value(_footer.text),
          reportHeaderHeightMm: Value(_parseMm(_headerH.text)),
          reportFooterHeightMm: Value(_parseMm(_footerH.text)),
        ),
      );
      if (!mounted) return;
      if (!quiet) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report print settings saved')),
        );
      }
      widget.onChanged();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.busy || _saving;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Show header on report (screen, print & PDF)'),
          value: _showHeader,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _showHeader = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Show footer on report (screen, print & PDF)'),
          value: _showFooter,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _showFooter = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Show section titles on report'),
          value: _showSectionTitles,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _showSectionTitles = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Color in-range values'),
          value: _colorInRange,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _colorInRange = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Color out-of-range values'),
          value: _colorOutOfRange,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _colorOutOfRange = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Flag low values'),
          value: _flagLow,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _flagLow = v);
                  await _save(quiet: true);
                },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Flag high values'),
          value: _flagHigh,
          onChanged: disabled
              ? null
              : (v) async {
                  setState(() => _flagHigh = v);
                  await _save(quiet: true);
                },
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _patientFont,
                enabled: !disabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Patient font (pt)'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _testsFont,
                enabled: !disabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tests font (pt)'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _descFont,
                enabled: !disabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Description font (pt)'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _headerH,
                enabled: !disabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Header height (mm)',
                  hintText: 'Auto',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _footerH,
                enabled: !disabled,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Footer height (mm)',
                  hintText: 'Auto',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _header,
          enabled: !disabled,
          maxLines: 6,
          decoration: const InputDecoration(
            labelText: 'Report Header HTML',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _footer,
          enabled: !disabled,
          maxLines: 6,
          decoration: const InputDecoration(
            labelText: 'Report Footer HTML',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Synced from web lab settings on .tt import. Edit only if you need a local override.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.tonalIcon(
            onPressed: disabled ? null : _save,
            icon: const Icon(Icons.save_outlined),
            label: Text(_saving ? 'Saving…' : 'Save report settings'),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: AppColors.muted))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  const _ThemeSwatch({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 86,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : AppColors.border,
            width: selected ? 2 : 1,
          ),
          color: selected ? color.withValues(alpha: 0.08) : Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: selected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
