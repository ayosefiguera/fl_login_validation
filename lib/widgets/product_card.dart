import 'package:fl_product/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 50),
        width: double.infinity,
        height: 350,
        decoration: _cardBorders(),
        child: Stack(
          children: [
            //background
            _Background(url: product.picture),
            Positioned(
              right: 0,
              top: 0,
              child: _PriceTag(price: product.price),
            ),
            if (!product.avaliable)
              Positioned(
                left: 0,
                top: 0,
                child: _NotAvaliable(),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              child: _ProductDetails(
                title: product.name,
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 5), blurRadius: 10),
        ]);
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: 350,
        child: url == null
            ? const Image(
                image: AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String title;
  const _ProductDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      width: 250,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag({required this.price});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: buildBoxDecoration(),
      height: 50,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('$price€',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ),
      ),
    );
  }
}

class _NotAvaliable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      height: 50,
      child: const Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Not avaliable',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: AppTheme.warningColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      );
}

BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: AppTheme.primaryColor,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
    );
