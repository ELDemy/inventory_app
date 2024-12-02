import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/widgets/report_details_card.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import 'employee_orders_report.dart';

class EmployeeDetailsCardReportCard extends StatelessWidget {
  const EmployeeDetailsCardReportCard({super.key, required this.employeeStats});
  final EmployeeStats employeeStats;

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
                employeeStats.employeeName,
                style: AppTextStyles.textStyle18,
              ),
            ],
          ),
          const SizedBox(height: 5),
          CustomResponsiveRow(
            children: [
              Text(
                "إجمالي الإيراد: ${employeeStats.totalRevenue}",
                style: AppTextStyles.textStyle18.copyWith(color: Colors.green),
              ),
              Text(
                "عدد الوحدات: ${employeeStats.totalUnits}",
                style: AppTextStyles.textStyle16.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          CustomResponsiveRow(
            children: [
              Text(
                "عدد العملاء: ${employeeStats.uniqueClients.length}",
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
              Text(
                "عدد الطلبات: ${employeeStats.orders.length}",
                style: AppTextStyles.textStyle14.copyWith(
                  color: AppColors.greyColor,
                ),
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
        builder: (_) => EmployeeOrdersReport(employeeStats: employeeStats),
      ),
    );
  }
}
