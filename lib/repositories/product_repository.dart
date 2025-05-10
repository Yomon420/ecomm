import 'package:ecomm/models/product.dart';
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

  // Add an item to the cart
  void addProductToCart(Product product) {
    _database.addToCart(product);
  }

  // Remove an item from the cart
  void removeProductFromCart(Product product) {
    _database.removeFromCart(product);
  }

  // Check if the cart contains any products
  bool checkProductInCart(Product product){
    return _database.checkCart(product);
  }

  // Display all products inside the cart
  List<Product> displayCartProducts() {
    return _database.getCartProducts();
  }

  // Remove product from the cart
  void removeCart(){
    _database.emptyCart();
  }
}