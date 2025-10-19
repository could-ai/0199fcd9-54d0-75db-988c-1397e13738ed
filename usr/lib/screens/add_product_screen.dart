import 'package:flutter/material.dart';
import '../models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Product) onAddProduct;

  const AddProductScreen({super.key, required this.onAddProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  String _selectedCategory = 'תפילה';

  final List<String> _categories = ['תפילה', 'מגילות', 'נרות', 'כלים'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: DateTime.now().toString(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        image: _imageController.text,
        category: _selectedCategory,
      );
      widget.onAddProduct(newProduct);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ המוצר התווסף בהצלחה!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'הוספת מוצר חדש',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'שם המוצר'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הזן שם מוצר';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'מחיר'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הזן מחיר';
                }
                if (double.tryParse(value) == null || double.parse(value) <= 0) {
                  return 'אנא הזן מחיר חיובי תקין';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'תיאור'),
              maxLines: 3,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הזן תיאור';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'כתובת URL של תמונה'),
              keyboardType: TextInputType.url,
               validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הזן כתובת תמונה';
                }
                if (!Uri.tryParse(value)!.isAbsolute) {
                    return 'אנא הזן URL תקין';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'קטגוריה'),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('הוסף מוצר'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
