import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'utils/app_routes.dart';
import 'service/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rotaInicial = await _rotaInicial();
  runApp(SMApp(rotaInicial: rotaInicial));
}

Future<String> _rotaInicial() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString('username');
  final password = prefs.getString('password');

  if (username == null || password == null) return AppRoutes.login;

  try {
    final token = await AuthService().login(username, password);
    await prefs.setString('token', token);
    return AppRoutes.products;
  } catch (_) {
    return AppRoutes.login;
  }
}

class SMApp extends StatelessWidget {
  final String rotaInicial;

  const SMApp({super.key, required this.rotaInicial});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: rotaInicial,
      routes: AppRoutes.routes,
    );
  }
}