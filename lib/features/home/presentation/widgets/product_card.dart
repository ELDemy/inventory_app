import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/product_management/product_screen/presentation/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 5,
      color: AppColors.primaryBackgroundColor,
      shadowColor: AppColors.primaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16, right: 8),
        child: Row(
          children: [
            _rightArrow(context),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName ?? "",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text("#${product.identifierSN}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الكمية: ${product.qty}"),
                      const SizedBox(width: 30),
                      Text("السعر : ${product.price}"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _rightArrow(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        if (product.identifierSN == null) return;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductScreen(identifierSN: product.identifierSN!)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Transform.flip(
          flipX: true,
          child: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
            width: 24,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Color get _cardColor {
    switch (product.qty) {
      case >= 15:
        return AppColors.primaryBackgroundColor;
      case >= 10:
        return AppColors.lightApprovedColor;
      case < 10:
        return AppColors.lightRejectedColor;
    }
    return AppColors.primaryBackgroundColor;
  }
}
