import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'utils/app_routes.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SMApp());
}

class SMApp extends StatelessWidget {
  const SMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      home: const LoginScreen(),
    );
  }
}
