import 'package:lab1_counter/widgets/auth_form_shell.dart';
import 'package:lab1_counter/widgets/custom_text_field.dart';
import 'package:lab1_counter/widgets/primary_button.dart';
import 'package:material_ui/material_ui.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: AuthFormShell(
        title: 'Створити акаунт',
        subtitle: 'Додайте свої мережеві вузли для віддаленого контролю',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomTextField(
              label: "Ім'я користувача",
              hint: 'Ілля Крупський',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              label: 'Електронна пошта',
              hint: 'user@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              label: 'Пароль',
              hint: 'Мінімум 8 символів',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Зареєструватися',
              icon: Icons.person_add_outlined,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/dashboard',
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Вже є акаунт? Повернутися до входу'),
            ),
          ],
        ),
      ),
    );
  }
}
