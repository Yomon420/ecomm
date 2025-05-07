import 'package:ecomm/view_models/product_view_model.dart';
import 'package:ecomm/views/cart_page.dart';
import 'package:ecomm/widget/custom_card.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static final String id = "Home Page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductViewModel _productViewModel = ProductViewModel();
  String _selectedItem = "all";

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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF2D3142),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CartPage(
                        cartProducts: _productViewModel.displayCartProducts(),
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future:
            _selectedItem.isEmpty
                ? _productViewModel.getProducts()
                : _productViewModel.getProductByCategory(
                  _productViewModel.getProducts(),
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
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: screenWidth / screenHeight * 1.3,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CustomCard(
                          product: product,
                          category: _selectedItem,
                          cart: _productViewModel.displayCartProducts(),
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
