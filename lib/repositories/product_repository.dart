import 'package:ecomm/models/product_model.dart';
import 'package:ecomm/repositories/product_database.dart';

class ProductRepository {
  final ProductDatabase _database = ProductDatabase();

  // Get products from cart with new quantities
  Future<List<Product>> getProducts() async {
    try {
      return await _database.fetchProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }
}