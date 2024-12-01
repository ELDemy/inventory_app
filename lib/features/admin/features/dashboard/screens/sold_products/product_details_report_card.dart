import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import '../home_dashboard/orders_history/order_history_short_report.dart';
import '../widgets/detailed_card_info.dart';

class ProductDetailsReportCard extends StatelessWidget {
  const ProductDetailsReportCard({
    super.key,
    required this.productStats,
    required this.reportCubit,
  });

  final ProductStats productStats;
  final DashboardCubit reportCubit;

  @override
  Widget build(BuildContext context) {
    return DetailedInfoCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: reportCubit,
              child: AllOrdersHistoryList(orders: productStats.orders),
            ),
          ),
        );
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
}
