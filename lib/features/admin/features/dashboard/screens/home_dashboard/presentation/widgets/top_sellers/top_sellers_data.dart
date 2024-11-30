import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TopSellersData extends StatelessWidget {
  const TopSellersData({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "محمود محمد احمد",
          style: AppTextStyles.textStyle18,
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "إجمالي الإيراد: ", // The static part
                style: AppTextStyles.textStyle14
                    .copyWith(color: AppColors.greyColor),
              ),
              TextSpan(
                text: "+ E£ 75", // The colored part
                style: AppTextStyles.textStyle14.copyWith(color: Colors.green),
              ),
            ],
          ),
        ),
        Text(
          "المنتجات المباعة: 75",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
