import 'package:ecomm/models/product.dart';
import 'package:ecomm/widget/custom_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cartProducts});
  final List<Product> cartProducts;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    getTotalPrice();
  }

  double getTotalPrice() {
    double total = 0;
    for (var product in widget.cartProducts) {
      total += product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              setState(() {
                widget.cartProducts;
              });
            },
          ),
        ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.63,
                ),
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = widget.cartProducts[index];
                  return CustomCard(
                    product: product,
                    category: "all",
                    cart: widget.cartProducts,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${getTotalPrice()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom( 
                      backgroundColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: (){
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => CheckoutPage(cartProducts: widget.cartProducts),
                      // ));
                    },
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
