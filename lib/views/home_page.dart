import 'package:ecomm/controller/cart_controller.dart';
import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/views/cart_page.dart';
import 'package:ecomm/widget/custom_card.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  final ProductController _productController;
  static final String id = "Home Page";
  final _allProducts;
  
  const HomePage({
    super.key,
    required productController,
    required allProducts,
  }) : 
  _productController = productController,
  _allProducts = allProducts;
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedItem = "all";
  CartController _cartController = CartController();
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "all",
      "men's clothing",
      "jewelery",
      "electronics",
      "women's clothing",
    ];
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // Animation
    PageRouteBuilder createSlideTransition(Widget page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Slide from the right (you can change the direction here)
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text(
          'E-commerce App',
          style: TextStyle(
            color: Color(0xFF2D3142),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined, color: Color(0xFF2D3142)),
            onPressed: () {
              setState(() {
                widget._productController;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF2D3142),
            ),
            onPressed: () {
              Navigator.push(
                context,
                createSlideTransition(
                  CartPage(CartController: _cartController, allProducts: widget._allProducts, productController: widget._productController,))).then((value){
                    setState(() {});});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future:
            _selectedItem.isEmpty
                ? widget._productController.getAllProducts()
                : widget._productController.getProductByCategory(
                  widget._allProducts,
                  _selectedItem,
                ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Color(0xFF2D3142)),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(color: Color(0xFF2D3142)),
              ),
            );
          } else {
            List<Product> products = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        ...items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _selectedItem == item
                                        ? Colors.red
                                        : const Color(0xFF2E7D32),
                                side: BorderSide(
                                  width: 3,
                                  color: Colors.yellow,
                                ),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedItem = item;
                                });
                              },
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: screenWidth / screenHeight * 1.3,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CustomCard(
                          product: product,
                          cartController: _cartController,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
