import 'package:ecomm/repositories/product_repository.dart';

import '../models/product_model.dart';

class ProductController {
  final ProductRepository _productRepository = ProductRepository();

  // Method to get products
  Future<List<Product>> getAllProducts() async {
    try {
      return await _productRepository.getProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }

  // Change the product in the home screen based on category
  Future<List<Product>> getProductByCategory(
    Future<List<Product>> productsFuture,
    String category,
  ) async {
    final products = await productsFuture;
    return category != "all"
        ? products.where((product) => product.getCategory() == category).toList()
        : products;
  }
}
