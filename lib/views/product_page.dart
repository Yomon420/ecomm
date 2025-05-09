import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.product,
    required this.productController,
  });
  final Product product;
  final ProductController productController;
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
                    widget.product.quantity != 0? "x${widget.product.quantity}" : "Out of Stock",
                    style: TextStyle(
                      color: widget.product.quantity != 0? const Color.fromARGB(255, 183, 169, 44) : Colors.red,
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
                              widget.productController.checkProductInUserCart(
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
                            if(widget.product.quantity != 0){
                              if (widget.productController.checkProductInUserCart(
                                widget.product,
                              )) {
                                widget.productController.removeProductFromUserCart(
                                widget.product,
                              );
                              } else {
                                widget.productController.addProductToUserCart(
                                widget.product,
                              );
                            }}
                          });
                        },
                        child:
                            !widget.productController.checkProductInUserCart(
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
