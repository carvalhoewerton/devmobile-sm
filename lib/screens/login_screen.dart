import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';
import '../utils/app_routes.dart';
import '../service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//Username: johnd Password: m38rmF$


class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _erro;

  Future<void> _fazerLogin() async {
    final username = _emailController.text.trim();
    final senha = _senhaController.text;

    if (username.isEmpty || senha.isEmpty) {
      setState(() => _erro = 'Preencha todos os campos');
      return;
    }

    try {
      final token = await AuthService().login(username, senha);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('username', username);
      await prefs.setString('password', senha);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso!'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.products);
      }
    } catch (e) {
      setState(() => _erro = e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: AppTheme.logoCircle,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'SM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Shop Management',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.bodyText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'BEM VINDO DE VOLTA!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.bodyText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        hint: 'Usuário',
                        prefixIcon: Icons.person_outline,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        hint: 'Senha',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        controller: _senhaController,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                color: AppTheme.linkColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                'Ainda não tem uma conta? ',
                                style: TextStyle(
                                  color: AppTheme.subtleText,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                                child: const Text(
                                  'Registre-se',
                                  style: TextStyle(
                                    color: AppTheme.linkColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (_erro != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _erro!,
                            style: const TextStyle(
                              color: AppTheme.error,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 20),
                      AppButton(
                        label: 'Entrar',
                        onPressed: _fazerLogin,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}