import 'package:lab1_counter/domain/models/user_model.dart';
import 'package:lab1_counter/domain/repositories/i_auth_repository.dart';
import 'package:lab1_counter/domain/validators/auth_validator.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:lab1_counter/ui/widgets/auth_form_shell.dart';
import 'package:lab1_counter/ui/widgets/custom_text_field.dart';
import 'package:lab1_counter/ui/widgets/primary_button.dart';
import 'package:material_ui/material_ui.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({required this.authRepository, super.key});

  final IAuthRepository authRepository;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = UserModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      await widget.authRepository.register(user);
      if (!mounted) {
        return;
      }
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (route) => false,
      );
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: AuthFormShell(
        title: 'Створити акаунт',
        subtitle: 'Додайте свої мережеві вузли для віддаленого контролю',
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: "Ім'я користувача",
                hint: 'Ілля Крупський',
                icon: Icons.person_outline,
                controller: _nameController,
                validator: AuthValidator.validateName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Електронна пошта',
                hint: 'user@example.com',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AuthValidator.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Пароль',
                hint: 'Мінімум 8 символів',
                icon: Icons.lock_outline,
                controller: _passwordController,
                obscureText: true,
                validator: AuthValidator.validatePassword,
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.offline),
                ),
              ],
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Зареєструватися',
                icon: Icons.person_add_outlined,
                isLoading: _isLoading,
                onPressed: _handleRegister,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text('Вже є акаунт? Повернутися до входу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
