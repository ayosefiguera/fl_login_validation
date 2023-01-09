import 'package:fl_product/themes/app_theme.dart';
import 'package:fl_product/ui/input_decorations.dart';
import 'package:fl_product/widgets/card_container.dart';
import 'package:fl_product/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Stack(children: [
              ProductImage(),
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
                    onPressed: () {},
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
                  child: ProductForm()),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () => Navigator.of(context).pop(),
      ),
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
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    bool _sliderEnable = true;
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            autocorrect: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Name:', labelText: 'Product\'s name'),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                hintText: '150', labelText: 'Product\'s price'),
          ),
          SwitchListTile.adaptive(
              value: _sliderEnable,
              title: Text('Avaliable'),
              activeColor: AppTheme.primaryColor,
              onChanged: ((value) {}))
        ],
      )),
    );
  }
}
