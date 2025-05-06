import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductViewModel {
  final ProductRepository productRepository = ProductRepository();

  // Method to get products
  Future<List<Product>> getProducts() async {
    try {
      return await productRepository.fetchProducts();
    } catch (e) {
      // Handle errors (maybe show error message to UI)
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<Product>> fetchCartProducts(List<Product> products) async{
    return products;
  }

  Future<List<Product>> getProductByCategory(Future<List<Product>> productsFuture, String category) async {
    final products = await productsFuture;
    return category!="all"? products.where((product) => product.category == category).toList(): getProducts();
  }
}
