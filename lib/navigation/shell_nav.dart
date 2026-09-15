import 'package:tubtrace_desktop/navigation/app_section.dart';

/// Cross-module navigation from TenantShell (patient focus + report).
typedef ShellNavigate = void Function(
  AppSection section, {
  int? patientId,
  bool openReport,
  bool autoPrint,
});
