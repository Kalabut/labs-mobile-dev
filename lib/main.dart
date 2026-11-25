import 'package:lab1_counter/screens/dashboard_screen.dart';
import 'package:lab1_counter/screens/login_screen.dart';
import 'package:lab1_counter/screens/registration_screen.dart';
import 'package:lab1_counter/screens/user_profile_screen.dart';
import 'package:lab1_counter/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const NetPulseApp());
}

class NetPulseApp extends StatelessWidget {
  const NetPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetPulse IoT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const UserProfileScreen(),
      },
    );
  }
}
