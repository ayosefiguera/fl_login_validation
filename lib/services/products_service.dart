import 'dart:io';

import 'package:flutter/material.dart';
import '../models/models.dart' show Product;
import 'package:fl_product/dev_key/api_keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class ProductService extends ChangeNotifier {
  final String _baseUrl = FirebaseData.url;
  final List<Product> products = [];
  File? newPictureFile;
  late Product selecteProduct;

  bool isLoading = false;
  bool isSaving = false;

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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await CreateProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future CreateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: product.toJson());
    final decodeData = json.decode(response.body);

    product.id = decodeData['name'];
    products.add(product);

    return product.id!;
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selecteProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(CloudinaryData.url);

    final imageUploarRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploarRequest.files.add(file);

    final streamResponse = await imageUploarRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    final decodeData = json.decode(resp.body);
    newPictureFile = null;

    isSaving = false;
    notifyListeners();
    return decodeData['secure_url'];
  }
}
