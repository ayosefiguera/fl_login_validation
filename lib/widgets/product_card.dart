import 'package:fl_product/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int index;

  const ProductCard({super.key, required this.index});
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 350,
                child: const FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(
                      'https://via.placeholder.com/400x300/f6f6f6'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //background
            Positioned(
              right: 0,
              top: 0,
              child: _PriceTag(),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: _NotAvaliable(),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: _ProductDetails(),
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

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      width: 250,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Disco duro G',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Disco duro G',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      height: 50,
      child: const Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$103,99€',
                style: TextStyle(color: Colors.white, fontSize: 14)),
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
