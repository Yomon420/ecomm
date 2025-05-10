import 'package:ecomm/repositories/product_repository.dart';

import '../models/product.dart';

class CartController {
  final ProductRepository _productRepository = ProductRepository();

  void addProductToUserCart(Product product) {
    _productRepository.addProductToCart(product);
  }

  void removeProductFromUserCart(Product product) {
    _productRepository.removeProductFromCart(product);
  }

  // For Product Page
  bool checkProductInUserCart(Product product){
    return _productRepository.checkProductInCart(product);
  }

  List<Product> displayCartProducts() {
    return _productRepository.displayCartProducts();
  }

  double getTotalPrice(){
    double total = 0;
    for (var product in _productRepository.displayCartProducts()) {
      total += product.getPrice() * product.getCount();
    }
    total = (total * 100).round() / 100;
    return total;
  }

  void processProductsAfterCheckout(){
    for (var product in _productRepository.displayCartProducts()) {
      var quantity = product.getQuantity();
      quantity -= product.getCount();
      product.setQuantity(quantity);
    }
  }

  void removeUesrCart(){
    _productRepository.removeCart();
  }

  // check if the cart contains an actual product
  bool checkCartCount(){
    for(var product in displayCartProducts()){
      if(product.getCount() > 0){
        return true;
      }
    }
    return false;
  }
}
