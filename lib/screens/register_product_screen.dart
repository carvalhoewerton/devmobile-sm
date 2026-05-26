import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';

class RegisterProductScreen extends StatefulWidget {
  const RegisterProductScreen({super.key});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _categoriaController = TextEditingController();
  String? _erro;

  Future<void> _salvarProduto() async {
    final nome = _nomeController.text.trim();
    final preco = double.tryParse(_precoController.text) ?? 0.0;
    final estoque = int.tryParse(_estoqueController.text) ?? 0;
    final categoria = _categoriaController.text.trim();

    if (nome.isEmpty || categoria.isEmpty || preco <= 0) {
      setState(() => _erro = 'Preencha os campos corretamente');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    
    final String? produtosJson = prefs.getString('lista_produtos');
    List<dynamic> listaProdutos = [];
    
    if (produtosJson != null) {
      listaProdutos = jsonDecode(produtosJson);
    }

    final novoProduto = {
      'nome': nome,
      'preco': preco,
      'estoque': estoque,
      'categoria': categoria,
    };

    listaProdutos.add(novoProduto);
    await prefs.setString('lista_produtos', jsonEncode(listaProdutos));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto cadastrado!'), backgroundColor: AppTheme.success),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Novo Produto', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DETALHES DO PRODUTO', 
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.subtleText)),
                const SizedBox(height: 20),
                AppTextField(
                  hint: 'Nome do Produto',
                  prefixIcon: Icons.shopping_cart_outlined,
                  controller: _nomeController,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: 'Categoria',
                  prefixIcon: Icons.category_outlined,
                  controller: _categoriaController,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hint: 'Preço (Ex: 10.50)',
                        prefixIcon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                        controller: _precoController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        hint: 'Estoque',
                        prefixIcon: Icons.inventory_2_outlined,
                        keyboardType: TextInputType.number,
                        controller: _estoqueController,
                      ),
                    ),
                  ],
                ),
                if (_erro != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_erro!, style: const TextStyle(color: AppTheme.error)),
                  ),
                const SizedBox(height: 32),
                AppButton(
                  label: 'Cadastrar Produto',
                  onPressed: _salvarProduto,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}