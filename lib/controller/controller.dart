import 'package:ecomm/repositories/product_repository.dart';

import '../models/product.dart';

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

  // Add an item to the cart
  void addProductToUserCart(Product product) {
    _productRepository.addProductToCart(product);
  }

  // Remove an item from cart
  void removeProductFromUserCart(Product product) {
    _productRepository.removeProductFromCart(product);
  }

  // Check if the cart contains any products
  bool checkProductInUserCart(Product product){
    return _productRepository.checkProductInCart(product);
  }

  // Display all items inside the cart
  List<Product> displayCartProducts() {
    return _productRepository.displayCartProducts();
  }

  // Get the total price for all items inside the cart
  double getTotalPrice(){
    double total = 0;
    for (var product in _productRepository.displayCartProducts()) {
      total += product.getPrice() * product.getCount();
    }
    total = (total * 100).round() / 100;
    return total;
  }

  // Minus the number of quantity for each item purchased
  void processProductsAfterCheckout(){
    for (var product in _productRepository.displayCartProducts()) {
      var quantity = product.getQuantity();
      quantity -= product.getCount();
      product.setQuantity(quantity);
    }
  }

  // Empty the cart after checkout
  void removeUesrCart(){
    _productRepository.removeCart();
  }

  // Check if the cart contains an actual product
  bool checkCartCount(){
    for(var product in displayCartProducts()){
      if(product.getCount() > 0){
        return true;
      }
    }
    return false;
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
