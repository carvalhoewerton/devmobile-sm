import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';
import '../utils/app_constants.dart';

class ProductService {
  
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('${AppConstants.baseUrl}/products'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }

    throw Exception('Erro ao buscar produtos: ${response.statusCode}');
  }

  Future<Product> createProduct({
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    }

    throw Exception('Erro ao cadastrar produto: ${response.statusCode}');
  }
}