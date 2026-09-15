import 'package:drift/drift.dart' show Value;
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
  late final _header = TextEditingController(text: widget.settings.reportHeaderHtml);
  late final _footer = TextEditingController(text: widget.settings.reportFooterHtml);
  late final _headerH = TextEditingController(
    text: widget.settings.reportHeaderHeightMm?.toString() ?? '',
  );
  late final _footerH = TextEditingController(
    text: widget.settings.reportFooterHeightMm?.toString() ?? '',
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
      _header.text = widget.settings.reportHeaderHtml;
      _footer.text = widget.settings.reportFooterHtml;
      _headerH.text = widget.settings.reportHeaderHeightMm?.toString() ?? '';
      _footerH.text = widget.settings.reportFooterHeightMm?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _header.dispose();
    _footer.dispose();
    _headerH.dispose();
    _footerH.dispose();
    super.dispose();
  }

  int? _parseMm(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    return int.tryParse(t);
  }

  Future<void> _save({bool quiet = false}) async {
    setState(() => _saving = true);
    try {
      final db = AppScope.of(context).db;
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        AppSettingsCompanion(
          showReportHeader: Value(_showHeader),
          showReportFooter: Value(_showFooter),
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
