import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';

class TopSellersData extends StatelessWidget {
  const TopSellersData({
    super.key,
    required this.employeeStats,
  });
  final EmployeeStats employeeStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employeeStats.employeeName,
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
                text: "+ E£ ${employeeStats.totalRevenue}", // The colored part
                style: AppTextStyles.textStyle14.copyWith(color: Colors.green),
              ),
            ],
          ),
        ),
        Text(
          "الوحدات المباعة: ${employeeStats.totalUnits}",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
