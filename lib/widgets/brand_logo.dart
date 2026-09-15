import 'package:flutter/material.dart';

/// Shared TubTrace brand mark (web logo).
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.size = 36,
    this.radius = 10,
    this.padding = 4,
    this.backgroundColor = Colors.white,
  });

  final double size;
  final double radius;
  final double padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Image.asset(
        'assets/branding/logo.jpg',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
