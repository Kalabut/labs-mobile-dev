// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_counter/main.dart';

void main() {
  testWidgets('Full navigation flow across all 4 screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NetPulseApp());

    // 1. LoginScreen
    expect(find.text('Вхід у NetPulse'), findsOneWidget);
    await tester.tap(find.text('Немає акаунту? Зареєструватися'));
    await tester.pumpAndSettle();

    // 2. RegistrationScreen
    expect(find.text('Створити акаунт'), findsOneWidget);
    await tester.tap(find.text('Зареєструватися'));
    await tester.pumpAndSettle();

    // 3. DashboardScreen
    expect(find.text('NetPulse • Мережа'), findsOneWidget);
    expect(find.text('Головний роутер'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.account_circle_outlined));
    await tester.pumpAndSettle();

    // 4. UserProfileScreen -> Logout back to LoginScreen
    expect(find.text('Профіль користувача'), findsOneWidget);
    await tester.tap(find.text('Вийти з акаунту'));
    await tester.pumpAndSettle();

    expect(find.text('Вхід у NetPulse'), findsOneWidget);
  });
}
