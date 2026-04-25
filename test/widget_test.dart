import 'package:flutter_test/flutter_test.dart';
import 'package:my_test_app/main.dart';

void main() {
  testWidgets('Open Budget app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const OpenBudgetApp());
    expect(find.text('Open Budget'), findsOneWidget);
  });
}
