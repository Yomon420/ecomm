import 'package:ecomm/view_models/product_view_model.dart';
import 'package:ecomm/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductViewModel _productViewModel = ProductViewModel();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 83, 251, 64),
        useMaterial3: true,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(productViewModel: _productViewModel,allProducts: _productViewModel.getProducts(),),
      initialRoute: HomePage.id,
      routes: {HomePage.id: (context) => HomePage(productViewModel: _productViewModel,allProducts: _productViewModel.getProducts(),)},
    );
  }
}
