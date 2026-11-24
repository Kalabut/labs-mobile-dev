import 'package:lab1_counter/data/repositories/local_auth_repository.dart';
import 'package:lab1_counter/data/repositories/local_network_node_repository.dart';
import 'package:lab1_counter/domain/repositories/i_auth_repository.dart';
import 'package:lab1_counter/domain/repositories/i_network_node_repository.dart';
import 'package:lab1_counter/ui/screens/dashboard_screen.dart';
import 'package:lab1_counter/ui/screens/login_screen.dart';
import 'package:lab1_counter/ui/screens/registration_screen.dart';
import 'package:lab1_counter/ui/screens/user_profile_screen.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final IAuthRepository authRepository = LocalAuthRepository();
  final INetworkNodeRepository nodeRepository = LocalNetworkNodeRepository();
  final currentUser = await authRepository.getCurrentUser();

  runApp(
    NetPulseApp(
      authRepository: authRepository,
      nodeRepository: nodeRepository,
      initialRoute: currentUser != null ? '/dashboard' : '/login',
    ),
  );
}

class NetPulseApp extends StatelessWidget {
  const NetPulseApp({
    required this.authRepository,
    required this.nodeRepository,
    this.initialRoute = '/login',
    super.key,
  });

  final IAuthRepository authRepository;
  final INetworkNodeRepository nodeRepository;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetPulse IoT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      routes: {
        '/login': (_) => LoginScreen(authRepository: authRepository),
        '/register': (_) => RegistrationScreen(authRepository: authRepository),
        '/dashboard': (_) => DashboardScreen(nodeRepository: nodeRepository),
        '/profile': (_) => UserProfileScreen(authRepository: authRepository),
      },
    );
  }
}
