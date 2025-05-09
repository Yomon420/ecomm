import 'package:ecomm/view_models/product_view_model.dart';
import 'package:ecomm/views/product_page.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class CustomCardCart extends StatefulWidget {
  final Product product;
  final String category;
  final ProductViewModel productViewModel;
  const CustomCardCart({
    super.key,
    required this.product,
    required this.category,
    required this.productViewModel,
  });

  @override
  State<CustomCardCart> createState() => _CustomCardCartState();
}

class _CustomCardCartState extends State<CustomCardCart> {
  Color changeColor() {
    var prod = widget.productViewModel.displayCartProducts();
    print(prod.length);
    for (int i = 0; i < prod.length; i++) {
      if (prod[i].title == widget.product.title) {
        return Colors.red;
      }
    }
    return const Color(0xFF2E7D32);
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>ProductPage(product: widget.product,productViewModel: widget.productViewModel,))
          ).then((value){
            setState(() {
              print("update home page");
            });
          });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withAlpha(1),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.product.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: changeColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.productViewModel.displayCartProducts().contains(widget.product)) {
                            widget.productViewModel.removeProductFromCart(widget.product);
                            print(widget.productViewModel.displayCartProducts().length);
                          } else {
                            widget.productViewModel.displayCartProducts().add(widget.product);
                            print(widget.productViewModel.displayCartProducts().length);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "x${widget.product.quantity}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                     style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if(widget.product.count > 0){
                            widget.product.count--;
                          }
                        });
                      },
                      icon: Icon(Icons.remove)
                      ),
                    Text(
                      "${widget.product.count}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if(widget.product.quantity > widget.product.count){
                            widget.product.count++;
                          }
                        });
                      },
                      icon: Icon(Icons.add)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
