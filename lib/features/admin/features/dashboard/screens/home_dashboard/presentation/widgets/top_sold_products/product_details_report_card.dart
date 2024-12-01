import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

class ProductDetailsReportCard extends StatelessWidget {
  const ProductDetailsReportCard({super.key, required this.productStats});

  final ProductStats productStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomResponsiveRow(
          children: [
            Text(
              productStats.productModel.productName ?? 'غير معرف',
              style: AppTextStyles.textStyle18,
            ),
            Text(
              productStats.productModel.identifierSN ?? 'غير معرف',
              style: AppTextStyles.textStyle12
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        const SizedBox(height: 5),
        CustomResponsiveRow(
          children: [
            Text(
              "السعر: ${productStats.totalRevenue} £E",
              style: AppTextStyles.textStyle18.copyWith(color: Colors.green),
            ),
            Text(
              "عدد الوحدات: ${productStats.totalUnits}",
              style: AppTextStyles.textStyle16
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        // CustomResponsiveRow(
        //   children: [
        //     Text(
        //       "عدد العملاء: ${productStats.uniqueCustomers}",
        //       style: AppTextStyles.textStyle14
        //           .copyWith(color: AppColors.greyColor),
        //     ),
        //     Text(
        //       "عدد البائعين: ${productStats.uniqueSellers}",
        //       style: AppTextStyles.textStyle14
        //           .copyWith(color: AppColors.greyColor),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
