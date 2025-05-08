import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductViewModel {
  final ProductRepository productRepository = ProductRepository();

  // Method to get products
  Future<List<Product>> getProducts() async {
    try {
      return await productRepository.fetchProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }

  void addProductToCart(Product product) {
    productRepository.addToCart(product);
  }

  void removeProductFromCart(Product product) {
    productRepository.removeFromCart(product);
  }

  List<Product> displayCartProducts() {
    return productRepository.getCartProducts();
  }

  double getTotalPrice(){
    double total = 0;
    for (var product in productRepository.getCartProducts()) {
      total += product.price * product.count;
    }
    total = (total * 100).round() / 100;
    return total;
  }

  void processProducts(){
    for (var product in productRepository.getCartProducts()) {
      product.quantity -= product.count;
    }
  }

  void removeCart(){
    productRepository.emptyCart();
  }

  Future<List<Product>> getProductByCategory(
    Future<List<Product>> productsFuture,
    String category,
  ) async {
    final products = await productsFuture;
    return category != "all"
        ? products.where((product) => product.category == category).toList()
        : products;
  }
}
