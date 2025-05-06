import 'package:ecomm/models/product.dart';
import 'package:ecomm/widget/custom_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget{
  const CartPage({super.key, required this.cartProducts});
  final List <Product> cartProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.63,
                          ),
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        return CustomCard(product: product, category: "all",getCart: (_) {},);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}