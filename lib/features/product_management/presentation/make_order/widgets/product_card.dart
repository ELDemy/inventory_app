import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

import 'my_order_card.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return MyOrderCard(
      title: "بيانات المنتج",
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProductDetail(
                  label: "اسم الموديل :",
                  content: "${productModel.productName ?? "###"} ",
                ),
                ProductDetail(
                  label: "المعرف :",
                  content: "${productModel.identifierSN ?? "###"} ",
                ),
                ProductDetail(
                  label: "Power :",
                  content: "${productModel.power ?? "###"} ",
                ),
                ProductDetail(
                  label: "Input :",
                  content: "${productModel.input ?? "###"} ",
                ),
                ProductDetail(
                  label: "Output :",
                  content: "${productModel.output ?? "###"} ",
                ),
                ProductDetail(
                  label: "السعر :",
                  content: "${productModel.price} ",
                ),
                ProductDetail(
                  label: "الكمية المتاحة :",
                  content: "${productModel.qty}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.label,
    required this.content,
  });

  final String label;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
