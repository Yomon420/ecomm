import 'package:ecomm/models/product.dart';

class CartModel {
  List<Product> _cartProducts = [];

  // Add an item to the cart
  void addToCart(Product product) {
    _cartProducts.add(product);
  }

  // Remove an item from the cart
  void removeFromCart(Product product) {
    _cartProducts.remove(product);
  }

  // Display items that is inside cart
  List<Product> getCartProducts() {
    return _cartProducts;
  }

  // Check if the cart contains any product
  bool checkCart(Product product){
    if(_cartProducts.contains(product)){
      return true;
    }
    return false;
  }

  // Empty the cart from any product inside it
  void emptyCart(){
    for(var product in _cartProducts){
      product.setCount(0);
    }
    _cartProducts = [];
  }
}