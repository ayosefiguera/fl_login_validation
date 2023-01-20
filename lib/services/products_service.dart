import 'package:flutter/material.dart';
import '../models/models.dart' show Product;
import 'package:fl_product/dev_key/api_keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class ProductService extends ChangeNotifier {
  final String _baseUrl = FirebaseData.url;
  final List<Product> products = [];
  late Product selecteProduct;

  bool isLoading = true;

  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);
    final Map<String, dynamic> productMap = json.decode(response.body);

    productMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }
}
