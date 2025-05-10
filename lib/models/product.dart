import 'dart:math';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

class Product {
  final String _title;
  final double _price;
  final String _description;
  final String _category;
  final String _imageUrl;
  final double _rating;
  final int _ratingCount;
  int _quantity;
  int _count;

  Product({
    required String title,
    required double price,
    required String description,
    required String category,
    required String imageUrl,
    required double rating,
    required int ratingCount,
    required int quantity,
    required int count,
  }) : 
  _title = title,
  _price = price,
  _description = description,
  _category = category,
  _imageUrl = imageUrl,
  _rating = rating,
  _ratingCount = ratingCount,
  _quantity = quantity,
  _count = count
  ;
  
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

  void setCount(int count){
    _count = count;
  }

  void setQuantity(int quantity){
    _quantity = quantity;
  }

  String getTitle(){
    return _title;
  }

  double getPrice(){
    return _price;
  }

  String getDescription(){
    return _description;
  }

  String getCategory(){
    return _category;
  }

  String getImageUrl(){
    return _imageUrl;
  }

  double getRating(){
    return _rating;
  }

  int getRatingCount(){
    return _ratingCount;
  }

  int getQuantity(){
    return _quantity;
  }

  int getCount(){
    return _count;
  }
}
