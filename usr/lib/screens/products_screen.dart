import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products;
  final Function(String) deleteProduct;

  const ProductsScreen({
    super.key,
    required this.products,
    required this.deleteProduct,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(
            child: Text(
              'אין מוצרים זמינים כרגע',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: product,
                        onDelete: () {
                          Navigator.pop(context); // Close detail screen
                          deleteProduct(product.id);
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('המוצר נמחק בהצלחה!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
