import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 450,
          child: ClipRRect(
            borderRadius: _buildBorderRadius,
            child: url == null
                ? const Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: const AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(url!),
                    fit: BoxFit.cover,
                  ),
          ),
        ));
  }

  final BorderRadius _buildBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(45), topRight: Radius.circular(45));

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: _buildBorderRadius,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(10, 5))
          ]);
}
