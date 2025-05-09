import 'package:ecomm/models/product.dart';
import 'package:ecomm/repositories/product_database.dart';

class ProductRepository {
  final ProductDatabase _database = ProductDatabase();

  Future<List<Product>> getProducts() async {
    try {
      return await _database.fetchProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }

  void addProductToCart(Product product) {
    _database.addToCart(product);
  }

  
  void removeProductFromCart(Product product) {
    _database.removeFromCart(product);
  }

  // For Product Page
  bool checkProductInCart(Product product){
    return _database.checkCart(product);
  }

  List<Product> displayCartProducts() {
    return _database.getCartProducts();
  }

  void removeCart(){
    _database.emptyCart();
  }
}