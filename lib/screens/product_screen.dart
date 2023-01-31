import 'dart:convert';

import 'package:fl_product/services/services.dart';
import 'package:fl_product/themes/app_theme.dart';
import 'package:fl_product/ui/input_decorations.dart';
import 'package:fl_product/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/models.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductService productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selecteProduct),
        child: _ProductScreenBody(
          product: productService.selecteProduct,
        ));
  }
}

class _ProductScreenBody extends StatelessWidget {
  final Product product;
  const _ProductScreenBody({required this.product});
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final ProductService productService = Provider.of<ProductService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Stack(children: [
              ProductImage(url: product.picture),
              Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.white70,
                    ),
                  )),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (pickedFile == null) {
                        print('no picture selected');
                        return;
                      }

                      productService
                          .updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white70,
                    ),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _buildBoxDecoration(),
                  width: double.infinity,
                  child: const ProductForm()),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: 
      FloatingActionButton(
              onPressed:  productService.isSaving 
              ? null
              : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;
                await productService.saveOrCreateProduct(productForm.product);
              },
              child: productService.isSaving 
              ?  const CircularProgressIndicator()
              :  const Icon(Icons.save_outlined),
            )
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: _buildBorderRadius,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(10, 5))
          ]);

  final BorderRadius _buildBorderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25));
}

class ProductForm extends StatelessWidget {
  const ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Form(
        key: productForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              initialValue: product.name,
              autocorrect: true,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Name:', labelText: 'Product\'s name'),
              onChanged: (value) => {product.name = value},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name can't be empty.";
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: '${product.price}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '150', labelText: 'Product\'s price'),
              onChanged: (value) => {
                if (double.tryParse(value) == null)
                  {product.price = 0}
                else
                  {product.price = double.parse(value)}
              },
              validator: (value) {
                if (value == null) {
                  return 'The price must be positive';
                }
                return null;
              },
            ),
            SwitchListTile.adaptive(
                value: product.avaliable,
                title: const Text('Avaliable'),
                activeColor: AppTheme.primaryColor,
                onChanged: productForm.updateAvailability)
          ],
        ));
  }
}
