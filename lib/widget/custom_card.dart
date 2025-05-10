import 'package:ecomm/controller/controller.dart';
import 'package:ecomm/views/product_page.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class CustomCard extends StatefulWidget {
  final Product product;
  final String category;
  final ProductController productController;
  const CustomCard({
    super.key,
    required this.product,
    required this.category,
    required this.productController,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>ProductPage(product: widget.product,productController: widget.productController,))
          ).then((value){
            setState(() {
              print("update home page");
            });
          });
      },
      child: Card(
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
                    widget.product.getImageUrl(),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.getTitle(),
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
                    "\$${widget.product.getPrice()}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.productController.checkProductInUserCart(widget.product)? Colors.red : const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if(widget.product.getQuantity() != 0)
                          {
                            if (widget.productController.displayCartProducts().contains(widget.product)) {
                              widget.productController.removeProductFromUserCart(widget.product);
                              print("No. of items in cart: "+widget.productController.displayCartProducts().length.toString());
                            } else {
                              widget.productController.displayCartProducts().add(widget.product);
                              print("No. of items in cart: "+widget.productController.displayCartProducts().length.toString());
                            }}else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Out of Stock"),
                                    duration: Duration(milliseconds: 600),
                                  ),
                                );
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
                widget.product.getQuantity() != 0?"x${widget.product.getQuantity()}":"Out of Stock",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
               style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.product.getQuantity() !=0? Color.fromARGB(255, 204, 189, 60) : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
