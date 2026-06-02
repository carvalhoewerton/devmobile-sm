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
}