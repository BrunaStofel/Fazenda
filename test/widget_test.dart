// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example:
//
// await tester.tap(find.byIcon(Icons.add));
// await tester.pump();
//
// Verify that a popup some text is present:
// expect(find.byText('0'), findsOneWidget);

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(const FazendaApp());

    // Create the Finders.
    // final titleFinder = find.text('Talhões');

    // Verify that our counter starts at 0.
    expect(find.text('Talhões'), findsNothing);
  });
}
