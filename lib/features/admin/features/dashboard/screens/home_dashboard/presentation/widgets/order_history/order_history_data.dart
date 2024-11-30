import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class OrderHistoryData extends StatelessWidget {
  const OrderHistoryData({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "VDS40-2S1.5",
              style: AppTextStyles.textStyle18,
            ),
            const SizedBox(width: 24),
            Text(
              "10/11/2024",
              style: AppTextStyles.textStyle16
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        Text(
          "#801R5G124FC",
          style: AppTextStyles.textStyle12.copyWith(color: AppColors.greyColor),
        ),
        const SizedBox(height: 10),
        Text(
          "75 £E", // The colored part
          style: AppTextStyles.textStyle14.copyWith(color: Colors.green),
        ),
        Text(
          "العميل: خاد عبدالله خالد",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
        Text(
          "البائع: محمد احمد",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
