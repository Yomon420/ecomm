import 'package:ecomm/models/product.dart';
import 'package:ecomm/view_models/product_view_model.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.product,
    required this.productViewModel,
  });
  final Product product;
  final ProductViewModel productViewModel;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.category,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Text(
              widget.product.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.product.imageUrl, scale: 5),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\$${widget.product.price}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "x${widget.product.quantity}",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 183, 169, 44),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "⭐${widget.product.rating}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            "(${widget.product.ratingCount})",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description:",
                style: TextStyle(
                  color: const Color.fromARGB(255, 138, 137, 137),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.description,
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              widget.productViewModel.checkProductInCart(
                                    widget.product,
                                  )
                                  ? Colors.green
                                  : Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (widget.productViewModel.checkProductInCart(
                              widget.product,
                            )) {
                              widget.productViewModel.removeProductFromCart(
                                widget.product,
                              );
                            } else {
                              widget.productViewModel.addProductToCart(
                                widget.product,
                              );
                            }
                          });
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content:
                          //         widget.productViewModel.checkProductInCart(
                          //               widget.product,
                          //             )
                          //             ? Text("Product added to cart")
                          //             : Text("Product removed from cart"),
                          //     duration: Duration(milliseconds: 600),
                          //     backgroundColor: Colors.green,
                          //   ),
                          // );
                        },
                        child:
                            !widget.productViewModel.checkProductInCart(
                                  widget.product,
                                )
                                ? Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                                : Text(
                                  "Remove From Cart",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
