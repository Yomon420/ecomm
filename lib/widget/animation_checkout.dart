// ignore_for_file: file_names
import 'package:ecomm/controller/cart_controller.dart';
import 'package:ecomm/views/home_page.dart';
import 'package:flutter/material.dart';

class AnimationCheckout extends StatefulWidget {
  final CartController _cartController;
  final _allProducts;
  final _productController;
  const AnimationCheckout({
    super.key,
    required cartController,
    required allProducts,
    required productController,
    }) : 
    _allProducts = allProducts,
    _cartController = cartController,
    _productController = productController
    ;

  @override
  State<AnimationCheckout> createState() => _AnimationCheckoutState();
}

class _AnimationCheckoutState extends State<AnimationCheckout> {
  @override
  void initState() {
    widget._cartController.processProductsAfterCheckout();
    widget._cartController.removeUesrCart();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(productController: widget._productController, allProducts: widget._allProducts)),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Image.asset(
            "android/assets/images/checkout.gif",
          ),
        ),
      ),
    );
  }
}
