import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/navigation/app_section.dart';
import 'package:tubtrace_desktop/navigation/shell_nav.dart';
import 'package:tubtrace_desktop/screens/analytics_page.dart';
import 'package:tubtrace_desktop/screens/doctors_page.dart';
import 'package:tubtrace_desktop/screens/enter_verify_page.dart';
import 'package:tubtrace_desktop/screens/patient_registration_page.dart';
import 'package:tubtrace_desktop/screens/patients_page.dart';
import 'package:tubtrace_desktop/screens/report_page.dart';
import 'package:tubtrace_desktop/screens/settings_page.dart';
import 'package:tubtrace_desktop/screens/tenant_dashboard_screen.dart';
import 'package:tubtrace_desktop/screens/tests_page.dart';
import 'package:tubtrace_desktop/screens/unlock_page.dart';
import 'package:tubtrace_desktop/services/lab_repository.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/brand_logo.dart';
import 'package:tubtrace_desktop/window_chrome.dart';
import 'package:tubtrace_desktop/window_sizes.dart';
import 'package:window_manager/window_manager.dart';

class TenantShell extends StatefulWidget {
  const TenantShell({super.key, this.initialSection = AppSection.dashboard});

  final AppSection initialSection;

  @override
  State<TenantShell> createState() => _TenantShellState();
}

class _TenantShellState extends State<TenantShell> {
  late AppSection _section = widget.initialSection;
  int? _focusPatientId;
  bool _autoPrint = false;
  String _labName = 'TubTrace';
  String _userLabel = 'Lab';
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadLab());
  }

  Future<void> _loadLab() async {
    final scope = AppScope.of(context);
    await LabRepository(scope.db).ensureSelfDoctor();
    final s = await scope.auth.settings();
    if (!mounted) return;
    setState(() {
      _labName = s.labName;
      _userLabel = s.labCode.isEmpty ? 'Lab' : s.labCode;
    });
  }

  void _go(
    AppSection section, {
    int? patientId,
    bool openReport = false,
    bool autoPrint = false,
  }) {
    setState(() {
      _section = openReport ? AppSection.report : section;
      _focusPatientId = patientId;
      _autoPrint = autoPrint;
    });
  }

  ShellNavigate get _navigate => _go;

  Future<void> _lockApp() async {
    final scope = AppScope.read(context);
    final enabled = await scope.auth.isSecurityEnabled;
    if (!enabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enable password security in Settings first.')),
      );
      return;
    }

    scope.setUnlocked(false);
    await openCardWindow(size: kCardWindowSize);
    if (!mounted) return;
    setState(() => _locked = true);
  }

  Future<void> _onUnlocked() async {
    AppScope.read(context).setUnlocked(true);
    await openMainWindow();
    if (!mounted) return;
    setState(() => _locked = false);
  }

  Future<void> _exitApp() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit TubTrace?'),
        content: const Text('Close the application now?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Exit')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await windowManager.destroy();
    } catch (_) {
      exit(0);
    }
  }

  Widget _body() {
    switch (_section) {
      case AppSection.dashboard:
        return DashboardPage(onNavigate: _navigate);
      case AppSection.registration:
        return PatientRegistrationPage(onNavigate: _navigate);
      case AppSection.patients:
        return PatientsPage(onNavigate: _navigate);
      case AppSection.enterVerify:
        return EnterVerifyPage(
          key: ValueKey('enter_${_focusPatientId ?? 0}'),
          initialPatientId: _focusPatientId,
          onNavigate: _navigate,
        );
      case AppSection.report:
        return ReportPage(
          key: ValueKey('report_${_focusPatientId ?? 0}_$_autoPrint'),
          patientId: _focusPatientId,
          autoPrint: _autoPrint,
          onNavigate: _navigate,
        );
      case AppSection.tests:
        return const TestsPage();
      case AppSection.doctors:
        return const DoctorsPage();
      case AppSection.analytics:
        return const AnalyticsPage();
      case AppSection.settings:
        return const SettingsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Keep Unlock under AppScope (do not push a root Navigator route).
    if (_locked) {
      return UnlockPage(onUnlocked: _onUnlocked, labName: _labName);
    }

    return Scaffold(
      body: Row(
        children: [
          _Sidebar(
            section: _section,
            labName: _labName,
            onSelect: _go,
            onLock: _lockApp,
            onExit: _exitApp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopHeader(section: _section, userLabel: _userLabel),
                Expanded(child: _body()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.section,
    required this.labName,
    required this.onSelect,
    required this.onLock,
    required this.onExit,
  });

  final AppSection section;
  final String labName;
  final ValueChanged<AppSection> onSelect;
  final VoidCallback onLock;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 244,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F1C24), Color(0xFF0B161C), Color(0xFF0D2422)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const BrandLogo(size: 40, radius: 12, padding: 4),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TubTrace Pro',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Offline',
                        style: TextStyle(color: Color(0xFF7DD3C7), fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'MENU',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.35),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (final item in AppSection.values.where((e) => e.showInSidebar))
                  _NavItem(
                    label: item.title,
                    icon: item.icon,
                    selected: section == item,
                    onTap: () => onSelect(item),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
            child: Row(
              children: [
                Expanded(
                  child: _SideAction(
                    icon: Icons.lock_outline,
                    label: 'Lock',
                    onTap: onLock,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SideAction(
                    icon: Icons.power_settings_new,
                    label: 'Exit',
                    onTap: onExit,
                    danger: true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
            child: Text(
              labName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideAction extends StatelessWidget {
  const _SideAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? const Color(0xFFFF8A80) : const Color(0xFFB6C7CF);
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Column(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: selected ? AppColors.sidebarActive : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.splashProgress.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: selected ? Colors.white : const Color(0xFF9BB0BA), size: 20),
        title: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFFC5D4DB),
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.section, required this.userLabel});

  final AppSection section;
  final String userLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: const BoxDecoration(
        color: AppColors.headerWash,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.splashAccent.withValues(alpha: 0.16),
                  AppColors.splashProgress.withValues(alpha: 0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(section.icon, color: AppColors.splashAccent, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.text),
              ),
              Text(section.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.softTeal,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.splashAccent.withValues(alpha: 0.18)),
            ),
            child: Row(
              children: [
                Icon(Icons.cloud_off_outlined, size: 15, color: AppColors.splashAccent),
                const SizedBox(width: 6),
                Text(
                  'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.splashAccent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.splashAccent.withValues(alpha: 0.15),
                  child: Text(
                    userLabel.isNotEmpty ? userLabel[0].toUpperCase() : 'L',
                    style: TextStyle(
                      color: AppColors.splashAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(userLabel, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.text)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
