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

  void addProduct(Product product) {
    productRepository.addToCart(product);
  }

  void removeProduct(Product product) {
    productRepository.removeFromCart(product);
  }

  List<Product> displayCartProducts() {
    return productRepository.getCartProducts();
  }

  Future<List<Product>> getProductByCategory(
    Future<List<Product>> productsFuture,
    String category,
  ) async {
    final products = await productsFuture;
    return category != "all"
        ? products.where((product) => product.category == category).toList()
        : getProducts();
  }
}
