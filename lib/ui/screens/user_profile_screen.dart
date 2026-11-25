import 'package:lab1_counter/domain/models/user_model.dart';
import 'package:lab1_counter/domain/repositories/i_auth_repository.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:lab1_counter/ui/widgets/primary_button.dart';
import 'package:lab1_counter/ui/widgets/profile_info_tile.dart';
import 'package:material_ui/material_ui.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({required this.authRepository, super.key});

  final IAuthRepository authRepository;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await widget.authRepository.getCurrentUser();
    if (!mounted) {
      return;
    }
    setState(() {
      _user = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await widget.authRepository.logout();
    if (!mounted) {
      return;
    }
    await Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль користувача')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 44,
                          backgroundColor: AppTheme.surface,
                          child: Icon(
                            Icons.person,
                            size: 44,
                            color: AppTheme.accent,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _user?.name ?? 'Гість',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Адміністратор домашньої Mesh-мережі',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 24),
                        ProfileInfoTile(
                          icon: Icons.email_outlined,
                          title: 'Електронна пошта',
                          value: _user?.email ?? 'Не авторизовано',
                        ),
                        const SizedBox(height: 8),
                        const ProfileInfoTile(
                          icon: Icons.speed,
                          title: 'Поріг тривоги пінгу',
                          value: '> 100 мс',
                        ),
                        const SizedBox(height: 8),
                        const ProfileInfoTile(
                          icon: Icons.wifi_tethering,
                          title: 'Мінімальний сигнал RSSI',
                          value: '-75 dBm',
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          label: 'Вийти з акаунту',
                          icon: Icons.logout,
                          onPressed: _logout,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
