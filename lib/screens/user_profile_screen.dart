import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/profile_info_tile.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль користувача')),
      body: SafeArea(
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
                    'Ілля Крупський',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Адміністратор домашньої Mesh-мережі',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  const ProfileInfoTile(
                    icon: Icons.email_outlined,
                    title: 'Електронна пошта',
                    value: 'illia.krupskyi@example.com',
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
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
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
