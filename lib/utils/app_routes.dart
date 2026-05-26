import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/register_screen.dart';
import '../screens/products_screen.dart';
import '../screens/register_product_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String register = '/register';
  static const String products = '/products'; 
  static const String registerProduct = '/register-product';

  static Map<String, WidgetBuilder> get routes => {
        login: (_) => const LoginScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        register: (_) => const RegisterScreen(),
        products: (_) => const ProductsScreen(),
        registerProduct: (_) => const RegisterProductScreen(),
      };
}
