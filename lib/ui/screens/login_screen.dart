import 'package:lab1_counter/domain/repositories/i_auth_repository.dart';
import 'package:lab1_counter/domain/validators/auth_validator.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:lab1_counter/ui/widgets/auth_form_shell.dart';
import 'package:lab1_counter/ui/widgets/custom_text_field.dart';
import 'package:lab1_counter/ui/widgets/primary_button.dart';
import 'package:material_ui/material_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.authRepository, super.key});

  final IAuthRepository authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final user = await widget.authRepository.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (user == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Невірна електронна пошта або пароль';
      });
      return;
    }

    await Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthFormShell(
        title: 'Вхід у NetPulse',
        subtitle: 'Моніторинг та керування вузлами бездротової мережі',
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                hint: 'Введіть пароль',
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
                label: 'Увійти',
                icon: Icons.login,
                isLoading: _isLoading,
                onPressed: _handleLogin,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () => Navigator.pushNamed(context, '/register'),
                child: const Text('Немає акаунту? Зареєструватися'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
