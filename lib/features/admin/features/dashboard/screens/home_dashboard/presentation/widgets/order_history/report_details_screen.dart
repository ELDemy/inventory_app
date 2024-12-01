import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/helpers/date_extension.dart';

class OrderDetailsReportCard extends StatelessWidget {
  const OrderDetailsReportCard({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomResponsiveRow(
          children: [
            Text(
              orderModel.product.productName ?? 'غير معرف',
              style: AppTextStyles.textStyle18,
            ),
            Text(
              "${orderModel.creationTime?.DayDate}",
              style: AppTextStyles.textStyle16
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        Text(
          orderModel.product.identifierSN ?? 'غير معرف',
          style: AppTextStyles.textStyle12.copyWith(color: AppColors.greyColor),
        ),
        const SizedBox(height: 5),
        CustomResponsiveRow(
          children: [
            Text(
              "السعر: ${orderModel.price} £E",
              style: AppTextStyles.textStyle18.copyWith(color: Colors.green),
            ),
            Text(
              "عدد الوحدات: ${orderModel.quantity}",
              style: AppTextStyles.textStyle16
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        ),
        CustomResponsiveRow(
          children: [
            Text(
              "العميل: ${orderModel.clientName}",
              style: AppTextStyles.textStyle14
                  .copyWith(color: AppColors.greyColor),
            ),
            Text(
              "البائع: ${orderModel.employee}",
              style: AppTextStyles.textStyle14
                  .copyWith(color: AppColors.greyColor),
            ),
          ],
        )
      ],
    );
  }
}
