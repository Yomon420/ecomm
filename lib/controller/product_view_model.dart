import 'package:ecomm/repositories/product_repository.dart';

import '../models/product.dart';

class ProductViewModel {
  final ProductRepository productRepository = ProductRepository();

  // Method to get products
  Future<List<Product>> getAllProducts() async {
    try {
      return await productRepository.getProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }

  void addProductToUserCart(Product product) {
    productRepository.addProductToCart(product);
  }

  void removeProductFromUserCart(Product product) {
    productRepository.removeProductFromCart(product);
  }

  // For Product Page
  bool checkProductInUserCart(Product product){
    return productRepository.checkProductInCart(product);
  }

  List<Product> displayCartProducts() {
    return productRepository.displayCartProducts();
  }

  double getTotalPrice(){
    double total = 0;
    for (var product in productRepository.displayCartProducts()) {
      total += product.price * product.count;
    }
    total = (total * 100).round() / 100;
    return total;
  }

  void processProductsAfterCheckout(){
    for (var product in productRepository.displayCartProducts()) {
      product.quantity -= product.count;
    }
  }

  void removeUesrCart(){
    productRepository.removeCart();
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
