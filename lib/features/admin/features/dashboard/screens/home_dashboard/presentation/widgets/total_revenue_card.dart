import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

class TotalRevenueCard extends StatelessWidget {
  const TotalRevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    ReportStatistics reportStatistics = context.watch<ReportCubit>().statistics;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.cardYellowBackgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _totalRevenueData(reportStatistics.totalRevenue),
            const SizedBox(height: 16),
            _dataRow("عدد الطلبات", "${reportStatistics.totalOrders} طلبات"),
            _dataRow(
                "عدد المنتجات", "${reportStatistics.totalProducts} منتجات"),
            _dataRow("عدد الوحدات", "${reportStatistics.totalUnits} وحدة"),
            _dataRow(
                "عدد العملاء", "${reportStatistics.uniqueCustomers} عملاء"),
          ],
        ),
      ),
    );
  }

  Row _totalRevenueData(double totalRevenue) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              const Text('إجمالي الإيرادات', style: AppTextStyles.headLine30),
              Text(
                '$totalRevenue £E',
                style: AppTextStyles.headLine24.copyWith(color: Colors.green),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _dataRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.textStyle22),
        Text(value, style: AppTextStyles.textStyle18),
      ],
    );
  }
}
