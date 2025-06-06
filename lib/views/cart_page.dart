import 'package:ecomm/controller/cart_controller.dart';
import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/widget/animation_checkout.dart';
import 'package:ecomm/widget/custom_card_cart.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final CartController _cartController;
  final _allProducts;
  final ProductController _productController;
  const CartPage({
    super.key,
    required CartController,
    required allProducts,
    required productController,
  }) : 
  _cartController = CartController,
  _allProducts = allProducts,
  _productController = productController;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var isLoading = false;

  Future<void> refreshPage() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              setState(() {
                refreshPage();
                widget._cartController;
              });
            },
          ),
        ],
      ),
      body:
          isLoading
              ? Center(
                child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 4 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: screenWidth / screenHeight * 1.3,
                        ),
                        itemCount:
                            widget._cartController.displayCartProducts().length,
                        itemBuilder: (context, index) {
                          final product =
                              widget._cartController.displayCartProducts()[index];
                          return CustomCardCart(
                            product: product,
                            cartController: widget._cartController,
                            onCartUpdate: (){
                              setState(() {
                                
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${widget._cartController.getTotalPrice()}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              if (widget._cartController.checkCartCount()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AnimationCheckout(
                                          cartController: widget._cartController,
                                          allProducts: widget._allProducts,
                                          productController: widget._productController,
                                        ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("No items in cart"),
                                    duration: Duration(milliseconds: 600),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
