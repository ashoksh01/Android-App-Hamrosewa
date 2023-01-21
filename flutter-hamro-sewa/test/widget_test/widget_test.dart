import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:najikkopasal/screens/login_success/login_success_screen.dart';

import 'package:najikkopasal/screens/ware/wareogin.dart';

void main() {
  //   Widget _wrapWithMaterialApp(DefaultButton appRaisedButton) {
  //   return MaterialApp(
  //     home: appRaisedButton,
  //   );

  // }

  testWidgets(" title widget testing in SigninSuccessScreen",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginSuccessScreen(),
    ));
    Finder title = find.text("Login Success");
    await tester.pumpAndSettle();
    expect(title, findsOneWidget);
  });

  testWidgets('Ware os ', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: WareosHome(),
    ));
    expect(find.byType(Column), findsOneWidget);
  });



 


 
}
