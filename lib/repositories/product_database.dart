import 'dart:convert';
import 'package:http/http.dart' as http; // To make HTTP requests
import '../models/product_model.dart'; // Product model file

class ProductDatabase {
  // The API URL
  // Method to fetch products from API
  Future<List<Product>> fetchProducts() async {
    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> data = json.decode(response.body);

        // Convert the JSON into Product objects
        return data
            .map((jsonProduct) => Product.fromJson(jsonProduct))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Catch any errors and throw them
      throw Exception('Error fetching products: $e');
    }
  }
}
