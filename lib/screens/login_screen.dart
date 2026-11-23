import 'package:material_ui/material_ui.dart';
import 'package:lab1_counter/widgets/auth_form_shell.dart';
import 'package:lab1_counter/widgets/custom_text_field.dart';
import 'package:lab1_counter/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthFormShell(
        title: 'Вхід у NetPulse',
        subtitle: 'Моніторинг та керування вузлами бездротової мережі',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomTextField(
              label: 'Електронна пошта',
              hint: 'user@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              label: 'Пароль',
              hint: 'Введіть пароль',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Увійти',
              icon: Icons.login,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Немає акаунту? Зареєструватися'),
            ),
          ],
        ),
      ),
    );
  }
}
