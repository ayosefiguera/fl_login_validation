import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductImage extends StatelessWidget {
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
            child: const FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
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
