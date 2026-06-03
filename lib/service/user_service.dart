import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';
import '../utils/app_constants.dart';

class UserService {
  Future<User> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return User(
        id: json['id'] ?? 0,
        username: json['username'] ?? username,
        email: json['email'] ?? email,
        password: json['password'] ?? password,
      );
    }

    throw Exception('Erro ao criar conta: ${response.statusCode}');
  }
}