import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/helpers/date_extension.dart';

class ShortOrderHistoryData extends StatelessWidget {
  const ShortOrderHistoryData({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderModel.product.productName ?? 'غير معرف',
                  style: AppTextStyles.textStyle18,
                ),
                Text(
                  orderModel.product.identifierSN ?? 'غير معرف',
                  style: AppTextStyles.textStyle12
                      .copyWith(color: AppColors.greyColor),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${orderModel.creationTime?.dayDate}",
                  style: AppTextStyles.textStyle16
                      .copyWith(color: AppColors.greyColor),
                ),
                Text(
                  "عدد الوحدات: ${orderModel.quantity}",
                  style: AppTextStyles.textStyle12
                      .copyWith(color: AppColors.greyColor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "${orderModel.price} £E", // The colored part
          style: AppTextStyles.textStyle14.copyWith(color: Colors.green),
        ),
        Text(
          "العميل: ${orderModel.clientName}",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
        Text(
          "البائع: ${orderModel.employee}",
          style: AppTextStyles.textStyle14.copyWith(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
