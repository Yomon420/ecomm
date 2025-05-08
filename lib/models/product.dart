import 'dart:math';

class Product {
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int ratingCount;
  int quantity;
  int count;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.quantity,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final random = Random();
    return Product(
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      imageUrl: json['image'],
      rating: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'],
      quantity: random.nextInt(10) + 1,
      count: 0,
    );
  }
}
