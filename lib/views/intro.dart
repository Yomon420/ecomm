import 'package:ecomm/controller/controller.dart';
import 'package:ecomm/views/home_page.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  final ProductController _productController;
  final _allProducts;
  const Intro({
    super.key,
    required productController,
    required allProducts
    }) : 
    _allProducts = allProducts,
    _productController = productController
    ;

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    widget._productController.processProductsAfterCheckout();
    widget._productController.removeUesrCart();
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
            //color: const Color.fromARGB(255, 221, 171, 24),
          ),
        ),
      ),
    );
  }
}
