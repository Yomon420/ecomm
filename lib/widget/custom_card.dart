import 'package:flutter/material.dart';

import '../models/product.dart';

class CustomCard extends StatelessWidget {
  Product product;
   CustomCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      surfaceTintColor: Colors.white,
      shadowColor: const Color.fromARGB(55, 0, 0, 0),
      color: const Color.fromARGB(23, 39, 37, 37),
      child: Container(
        padding: const EdgeInsets.only(top:20,right: 20, left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.network(
                product.imageUrl,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(height: 10),
             Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
             Text(
               ("\$${product.price}"),
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart, color: Colors.white,))
          ],
        ),
      ),
    );
  }
}