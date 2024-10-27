import 'package:flutter/material.dart';

import 'order_form.dart';
import 'product_details_card.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            ProductDetailsCard(),
            OrderForm(),
          ],
        ),
      ),
    );
  }
}
