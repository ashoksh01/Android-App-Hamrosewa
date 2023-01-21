import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:najikkopasal/screens/sign_in/sign_in_screen.dart';
import 'package:najikkopasal/screens/sign_up/sign_up_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing the widgets", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/signUp': (context) => const SignUpScreen(),
      },
      home: const SignInScreen(),
    ));
    Finder first_number = find.byKey(const ValueKey("email"));
    await tester.enterText(first_number, "baba@gmail.com");
    Finder second_number = find.byKey(const ValueKey("password"));
    await tester.enterText(second_number, "Baba1412914@");
    Finder btnAdd = find.byKey(const ValueKey("Login"));
    await tester.dragUntilVisible(
      btnAdd,
      find.byType(Scaffold),
      const Offset(0, 70),
    );
    await tester.tap(btnAdd);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
