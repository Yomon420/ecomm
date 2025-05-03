import 'package:ecomm/widget/custom_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final String id = "Home Page";
  
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
    "All",
    "Shoes",
    "Clothes",
    "Accessories",];
    // List<String> items2 = [
    //   "android/assets/images/shoes.png",
    // ];
    return Scaffold(
      //appBar: AppBar(title: Text("Home Page"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onPressed: (){} 
                    , child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 50),
          CustomCard(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.redAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          //BottomNavigationBarItem(icon: Icon(Icons.man), label: "Profile"),
        ],
      ),
    );
  }
}
