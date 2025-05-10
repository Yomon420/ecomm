import 'package:ecomm/models/cart_model.dart';
import 'package:ecomm/models/product.dart';

class CartController {
  final CartModel _cartModel = CartModel();
  // Add an item to the cart
  void addProductToUserCart(Product product) {
    _cartModel.addToCart(product);
  }

  // Remove an item from cart
  void removeProductFromUserCart(Product product) {
    _cartModel.removeFromCart(product);
  }

  // Check if the cart contains any products
  bool checkProductInUserCart(Product product){
    return _cartModel.checkCart(product);
  }

  // Display all items inside the cart
  List<Product> displayCartProducts() {
    return _cartModel.getCartProducts();
  }

  // Get the total price for all items inside the cart
  double getTotalPrice(){
    double total = 0;
    for (var product in _cartModel.getCartProducts()) {
      total += product.getPrice() * product.getCount();
    }
    total = (total * 100).round() / 100;
    return total;
  }

  // Minus the number of quantity for each item purchased
  void processProductsAfterCheckout(){
    for (var product in _cartModel.getCartProducts()) {
      var quantity = product.getQuantity();
      quantity -= product.getCount();
      product.setQuantity(quantity);
    }
  }

  // Empty the cart after checkout
  void removeUesrCart(){
    _cartModel.emptyCart();
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