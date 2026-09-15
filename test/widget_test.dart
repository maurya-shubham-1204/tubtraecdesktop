import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrace_desktop/main.dart';

void main() {
  testWidgets('App boots to splash', (tester) async {
    await tester.pumpWidget(const TubTraceDesktopApp());
    expect(find.text('TubTrace'), findsOneWidget);
  });
}
