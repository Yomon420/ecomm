import 'package:ecomm/repositories/product_repository.dart';

import '../models/product.dart';

class CartController {
  final ProductRepository _productRepository = ProductRepository();

  // Add an item to the cart
  void addProductToUserCart(Product product) {
    _productRepository.addProductToCart(product);
  }

  // Remove an item from cart
  void removeProductFromUserCart(Product product) {
    _productRepository.removeProductFromCart(product);
  }

  // For Product Page
  bool checkProductInUserCart(Product product){
    return _productRepository.checkProductInCart(product);
  }

  // Display all items inside the cart
  List<Product> displayCartProducts() {
    return _productRepository.displayCartProducts();
  }

  // Get the total price for all the items inside the cart
  double getTotalPrice(){
    double total = 0;
    for (var product in _productRepository.displayCartProducts()) {
      total += product.getPrice() * product.getCount();
    }
    total = (total * 100).round() / 100;
    return total;
  }

  // Empty the cart after the checkout finished
  void processProductsAfterCheckout(){
    for (var product in _productRepository.displayCartProducts()) {
      var quantity = product.getQuantity();
      quantity -= product.getCount();
      product.setQuantity(quantity);
    }
  }

  // Empty the cart
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
}
