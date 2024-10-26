import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/product_model.dart';

import 'order_form.dart';
import 'product_card.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ProductCard(productModel: productModel),
            OrderForm(productModel: productModel),
          ],
        ),
      ),
    );
  }
}
