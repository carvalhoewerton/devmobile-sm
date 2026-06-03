import 'package:flutter/material.dart';
import '../service/product_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';

class RegisterProductScreen extends StatefulWidget {
  const RegisterProductScreen({super.key});

  @override
  State<RegisterProductScreen> createState() => _RegisterProductScreenState();
}

class _RegisterProductScreenState extends State<RegisterProductScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  bool _isLoading = false;
  String? _erro;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _salvarProduto() async {
    final title = _titleController.text.trim();
    final price = double.tryParse(_priceController.text.replaceAll(',', '.'));
    final description = _descriptionController.text.trim();
    final category = _categoryController.text.trim();
    final image = _imageController.text.trim();

    if (title.isEmpty || price == null || price <= 0 || description.isEmpty || category.isEmpty) {
      setState(() => _erro = 'Preencha todos os campos obrigatórios corretamente.');
      return;
    }

    setState(() {
      _isLoading = true;
      _erro = null;
    });

    try {
      await ProductService().createProduct(
        title: title,
        price: price,
        description: description,
        category: category,
        image: image.isEmpty ? 'https://i.pravatar.cc' : image,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produto cadastrado com sucesso!'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() => _erro = 'Erro ao cadastrar produto. Tente novamente.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                const Text(
                  'DETALHES DO PRODUTO',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.subtleText),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  hint: 'Nome do Produto *',
                  prefixIcon: Icons.shopping_cart_outlined,
                  controller: _titleController,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: 'Categoria *',
                  prefixIcon: Icons.category_outlined,
                  controller: _categoryController,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: 'Preço (Ex: 10.50) *',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  maxLines: 1,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: 'Descrição *',
                  prefixIcon: Icons.description_outlined,
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  hint: 'URL da Imagem (opcional)',
                  prefixIcon: Icons.image_outlined,
                  controller: _imageController,
                  keyboardType: TextInputType.url,
                  maxLines: 1,
                ),
                if (_erro != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(_erro!, style: const TextStyle(color: AppTheme.error)),
                  ),
                const SizedBox(height: 32),
                AppButton(
                  label: _isLoading ? 'Cadastrando...' : 'Cadastrar Produto',
                  onPressed: _isLoading ? () {} : () => _salvarProduto(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}