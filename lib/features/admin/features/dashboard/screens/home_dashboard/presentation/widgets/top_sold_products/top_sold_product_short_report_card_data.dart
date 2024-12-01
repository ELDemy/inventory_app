import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

class TopSoldProductCardData extends StatelessWidget {
  const TopSoldProductCardData({
    super.key,
    required this.productStats,
  });
  final ProductStats productStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productStats.productModel.productName ?? 'غير معرف',
          style: AppTextStyles.textStyle18,
        ),
        Text(
          productStats.productModel.identifierSN ?? 'غير معرف',
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
                text: "E£ ${productStats.totalRevenue}", // The colored part
                style: AppTextStyles.textStyle14.copyWith(color: Colors.green),
              ),
            ],
          ),
        ),
        Text(
          "الوحدات المباعة: ${productStats.totalUnits}",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
