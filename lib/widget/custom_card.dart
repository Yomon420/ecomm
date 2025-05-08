import 'package:ecomm/view_models/product_view_model.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class CustomCard extends StatefulWidget {
  final Product product;
  final String category;
  final ProductViewModel cart;
  const CustomCard({
    super.key,
    required this.product,
    required this.category,
    required this.cart,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  Color changeColor() {
    var prod = widget.cart.displayCartProducts();
    print(prod.length);
    for (int i = 0; i < prod.length; i++) {
      if (prod[i].title == widget.product.title) {
        return Colors.red;
      }
    }
    return const Color(0xFF2E7D32);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withAlpha(1),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3142),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: changeColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.cart.displayCartProducts().contains(widget.product)) {
                          widget.cart.displayCartProducts().remove(widget.product);
                          print(widget.cart.displayCartProducts().length);
                        } else {
                          widget.cart.displayCartProducts().add(widget.product);
                          print(widget.cart.displayCartProducts().length);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
            Text(
              "x${widget.product.quantity}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
             style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
