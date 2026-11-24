import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_counter/data/repositories/local_auth_repository.dart';
import 'package:lab1_counter/data/repositories/local_network_node_repository.dart';
import 'package:lab1_counter/main.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Full auth and navigation flow', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final authRepo = LocalAuthRepository();
    final nodeRepo = LocalNetworkNodeRepository();

    await tester.pumpWidget(
      NetPulseApp(authRepository: authRepo, nodeRepository: nodeRepo),
    );

    // 1. LoginScreen -> RegistrationScreen
    expect(find.text('Вхід у NetPulse'), findsOneWidget);
    await tester.tap(find.text('Немає акаунту? Зареєструватися'));
    await tester.pumpAndSettle();

    // 2. Fill valid registration form
    expect(find.text('Створити акаунт'), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ілля Крупський');
    await tester.enterText(fields.at(1), 'illia@example.com');
    await tester.enterText(fields.at(2), 'password123');
    await tester.tap(find.text('Зареєструватися'));
    await tester.pumpAndSettle();

    // 3. DashboardScreen -> UserProfileScreen
    expect(find.text('NetPulse • Мережа'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.account_circle_outlined));
    await tester.pumpAndSettle();

    // 4. Verify profile data & logout
    expect(find.text('Ілля Крупський'), findsOneWidget);
    expect(find.text('illia@example.com'), findsOneWidget);
    await tester.tap(find.text('Вийти з акаунту'));
    await tester.pumpAndSettle();

    expect(find.text('Вхід у NetPulse'), findsOneWidget);
  });
}
