import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TotalRevenueCard extends StatelessWidget {
  const TotalRevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0x56FFD456),
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
            _totalRevenueData(),
            const SizedBox(height: 16),
            _dataRow("عدد المنتجات", "20 منتج"),
            _dataRow("عدد العملاء", "10 عملاء"),
          ],
        ),
      ),
    );
  }

  Row _totalRevenueData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('إجمالي الإيرادات', style: AppTextStyles.headLine30),
        Text(
          '+5000 £E',
          style: AppTextStyles.headLine24.copyWith(color: Colors.green),
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
