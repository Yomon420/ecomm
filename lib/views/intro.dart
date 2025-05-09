import 'package:ecomm/view_models/product_view_model.dart';
import 'package:ecomm/views/home_page.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  final ProductViewModel productViewModel;
  final allProducts;
  const Intro({super.key, required this.productViewModel, required this.allProducts});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    widget.productViewModel.processProductsAfterCheckout();
    widget.productViewModel.removeCart();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(productViewModel: widget.productViewModel, allProducts: widget.allProducts)),
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
