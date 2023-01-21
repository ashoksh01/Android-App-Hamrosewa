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
        '/sign_in': (context) => const SignInScreen(),
      },
      home: const SignUpScreen(),
    ));
    Finder name = find.byKey(const ValueKey("name"));
    await tester.enterText(name, "Malaika");
    Finder email = find.byKey(const ValueKey("email"));
    await tester.enterText(email, "mahatohbha@gmail.com");
    Finder password = find.byKey(const ValueKey("password"));
    await tester.enterText(password, "baba1412914@");
    Finder signup = find.byKey(const ValueKey("SignUp"));
    await tester.dragUntilVisible(
      signup,
      find.byType(Scaffold),
      const Offset(0, 70),
    );
    await tester.tap(signup);
    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
