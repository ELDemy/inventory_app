import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TopSoldProductCardData extends StatelessWidget {
  const TopSoldProductCardData({
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
          "VDS40-2S1.5",
          style: AppTextStyles.textStyle18,
        ),
        Text(
          "#801R5G124FC",
          style: AppTextStyles.textStyle12.copyWith(color: AppColors.greyColor),
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
