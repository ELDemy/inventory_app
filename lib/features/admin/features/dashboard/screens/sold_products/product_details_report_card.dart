import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/widgets/report_details_card.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import 'product_orders_report/product_orders_report_list.dart';

class ProductDetailsReportCard extends StatelessWidget {
  const ProductDetailsReportCard({super.key, required this.productStats});
  final ProductStats productStats;

  @override
  Widget build(BuildContext context) {
    return ReportDetailsCard(
      onCardTap: () {
        _onCardTap(context);
      },
      child: Column(
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
          CustomResponsiveRow(
            children: [
              Text(
                "عدد العملاء: ${productStats.uniqueClients.length}",
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
              Text(
                "عدد الطلبات: ${productStats.orders.length}",
                style: AppTextStyles.textStyle14
                    .copyWith(color: AppColors.greyColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onCardTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ProductOrdersReportList(productStats: productStats)),
    );
  }
}
