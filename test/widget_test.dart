// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_registration_app/main.dart';

void main() {
  testWidgets('App builds and shows splash content', (WidgetTester tester) async {
    GoogleFonts.config.allowRuntimeFetching = false; // keep tests offline
    await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  // After splash, the Welcome screen shows primary CTA
  expect(find.text('Login'), findsOneWidget);
  });
}
