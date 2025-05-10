// ignore_for_file: file_names

import 'package:ecomm/controller/cart_controller.dart';
import 'package:ecomm/views/home_page.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  final CartController _cartController;
  final _allProducts;
  const Intro({
    super.key,
    required cartController,
    required allProducts
    }) : 
    _allProducts = allProducts,
    _cartController = cartController
    ;

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    widget._cartController.processProductsAfterCheckout();
    widget._cartController.removeUesrCart();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(productController: widget._cartController, allProducts: widget._allProducts)),
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
