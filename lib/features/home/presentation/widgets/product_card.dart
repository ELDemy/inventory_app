import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/product_management/product_profile/presentation/product_profile_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _cardColor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 8),
        child: Row(
          children: [
            _rightArrow(context),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Text(
                              product.productName ?? "###",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${product.identifierSN}#",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.inventory_rounded,
                                    size: 16, color: _cardColor),
                                Text(
                                  "  ${product.qty} ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: _cardColor,
                                  ),
                                ),
                              ],
                            ),
                            Text("السعر : ${product.price}\$"),
                          ],
                        ),
                      ),
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
      onTap: () async {
        await product.logViewEvent();
        if (product.identifierSN == null) return;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductProfileScreen(identifierSN: product.identifierSN!)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Transform.flip(
          flipX: true,
          child: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
            width: 24,
            colorFilter: ColorFilter.mode(_cardColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Color get _cardColor {
    switch (product.qty) {
      case >= 3:
        return AppColors.primaryColor;
      case < 3:
        return AppColors.lightRedColor;
      default:
        return AppColors.primaryColor;
    }
  }
}
