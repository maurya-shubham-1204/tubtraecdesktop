import 'package:flutter/material.dart';

enum AppSection {
  dashboard,
  registration,
  patients,
  enterVerify,
  report,
  tests,
  doctors,
  analytics,
  settings,
}

extension AppSectionX on AppSection {
  String get title {
    switch (this) {
      case AppSection.dashboard:
        return 'Dashboard';
      case AppSection.registration:
        return 'New Billing';
      case AppSection.patients:
        return 'Patient List';
      case AppSection.enterVerify:
        return 'Enter and Verify';
      case AppSection.report:
        return 'Report';
      case AppSection.tests:
        return 'Tests';
      case AppSection.doctors:
        return 'Doctors';
      case AppSection.analytics:
        return 'Analytics';
      case AppSection.settings:
        return 'Settings';
    }
  }

  String get subtitle {
    switch (this) {
      case AppSection.dashboard:
        return 'Lab overview';
      case AppSection.registration:
        return 'Step 1 patient · Step 2 tests & payment';
      case AppSection.patients:
        return 'Search and open patient cases';
      case AppSection.enterVerify:
        return 'Enter readings and verify reports';
      case AppSection.report:
        return 'Printable lab report';
      case AppSection.tests:
        return 'Local test catalog';
      case AppSection.doctors:
        return 'Referring doctors and commissions';
      case AppSection.analytics:
        return 'Collections, volume and exports';
      case AppSection.settings:
        return 'Security, backup and lab info';
    }
  }

  IconData get icon {
    switch (this) {
      case AppSection.dashboard:
        return Icons.grid_view_rounded;
      case AppSection.registration:
        return Icons.receipt_long_outlined;
      case AppSection.patients:
        return Icons.people_outline;
      case AppSection.enterVerify:
        return Icons.fact_check_outlined;
      case AppSection.report:
        return Icons.print_outlined;
      case AppSection.tests:
        return Icons.science_outlined;
      case AppSection.doctors:
        return Icons.medical_services_outlined;
      case AppSection.analytics:
        return Icons.insights_outlined;
      case AppSection.settings:
        return Icons.settings_outlined;
    }
  }

  bool get showInSidebar {
    switch (this) {
      case AppSection.report:
        return false;
      default:
        return true;
    }
  }
}
