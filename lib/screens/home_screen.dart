import 'package:fl_product/screens/screens.dart';
import 'package:fl_product/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import '../models/models.dart';
import '../services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final product = productService.products;
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                productService.selecteProduct =
                    productService.products[index].copy();
                Navigator.pushNamed(context, 'product');
              },
              child: ProductCard(product: product[index]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selecteProduct =
              Product(avaliable: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
