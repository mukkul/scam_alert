import 'package:flutter_test/flutter_test.dart';
import 'package:scam_alert/main.dart' as app;

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byType(app.MyApp), findsOneWidget);
  });
}
