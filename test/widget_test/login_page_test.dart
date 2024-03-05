import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';
import 'package:hamropasalmobile/features/auth/presentation/view/login_view.dart';
import 'package:hamropasalmobile/features/auth/presentation/view/register_view.dart';

void main() {
  testWidgets('LoginView widget test', (tester) async {
    // Pump the LoginView widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginView(),
        ),
      ),
    );

    // Wait for the widget to render
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('username')), findsOneWidget);

    // Test if 'Password' text field is displayed
    expect(find.byKey(const ValueKey('password')), findsOneWidget);

    // // // Test if 'Login' button is displayed
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Wait for the validation to complete
    await tester.pumpAndSettle();

    // Enter valid email and password
    await tester.enterText(
        find.byKey(const ValueKey('username')), 'prasnaworks@gmail.com');
    await tester.enterText(
        find.byKey(const ValueKey('password')), 'Password123\$');

    // Wait for the navigation to complete
    await tester.pumpAndSettle();

    // expect(find.text('Dont have an account ? '), findsOneWidget);
  });

  group("login test widget", () {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('Login testing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid email and password
      await tester.enterText(
          find.byKey(const ValueKey('username')), 'a@gmail.com');
      await tester.enterText(find.byKey(const ValueKey('password')), '123');

      // Tap on the 'Login' button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
    });
  });

  group("register test widget", () {
    testWidgets('renders RegisterView from login page on click',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const LoginView(),
            routes: AppRoute.getApplicationRoute(),
          ),
        ),
      );

      // Wait for the widgets to settle
      await tester.pumpAndSettle();

      // Tap the button with the specified key ("registerButton")
      await tester.tap(find.byKey(const ValueKey('registerButton')));

      // Wait for the widgets to settle after the button tap
      await tester.pumpAndSettle();

      // Ensure that the RegisterView is rendered
      expect(find.byType(RegisterView), findsOneWidget);
    });
  });

  testWidgets('renders RegisterView', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: RegisterView(),
        ),
      ),
    );
    // Expect that a Scaffold is rendered
    expect(find.byType(Scaffold), findsOneWidget);
    // Expect that the RegisterPage is rendered
    expect(find.byType(RegisterView), findsOneWidget);
  });
}
