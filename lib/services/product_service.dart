import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl =
      'https://flutter-varios-163eb-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];
}
