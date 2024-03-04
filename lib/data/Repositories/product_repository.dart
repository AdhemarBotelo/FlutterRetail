import 'dart:convert';

import '../API/api_helper.dart';
import '../API/models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final response = await MyHttpClient.get<List<Product>>('/products');
    if (response.success) {
      var decodedJson = jsonDecode(response.stringData ?? "") as List<dynamic>;
      return decodedJson
          .map((dynamic product) => Product.fromJson(product))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future<Product?> fetchProductById(String id) async {
    final response = await MyHttpClient.get<Product>('/products/$id');
    if (response.success) {
      return Product.fromJson(jsonDecode(response.stringData!));
    } else {
      return null;
    }
  }
}
