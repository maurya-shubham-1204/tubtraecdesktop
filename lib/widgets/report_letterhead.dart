import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// Renders web lab_settings report header/footer HTML.
class ReportLetterheadHtml extends StatelessWidget {
  const ReportLetterheadHtml({
    super.key,
    required this.html,
    this.heightMm,
  });

  final String html;
  final int? heightMm;

  @override
  Widget build(BuildContext context) {
    final trimmed = html.trim();
    if (trimmed.isEmpty) return const SizedBox.shrink();

    Widget child = HtmlWidget(
      trimmed,
      textStyle: const TextStyle(fontSize: 13, height: 1.25),
    );

    if (heightMm != null && heightMm! > 0) {
      final h = heightMm! * 3.78; // ~mm → logical px at 96dpi
      child = SizedBox(
        height: h,
        width: double.infinity,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}
