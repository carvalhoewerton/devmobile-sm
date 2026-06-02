import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_constants.dart';

class AuthService {
  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return data['token'] as String;
    }

    throw Exception('Usuário ou senha inválidos');
  }
}