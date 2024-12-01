import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';
import 'package:inventory_app/helpers/date_extension.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({
    super.key,
    required this.title,
    required this.data1,
    required this.data2,
    required this.onCardTap,
    required this.childBuilder,
  });

  final String title;
  final String data1;
  final String data2;
  final Widget Function(int index) childBuilder;
  final Function(int index) onCardTap;
  @override
  Widget build(BuildContext context) {
    List<OrderModel> allOrders = context.read<ReportCubit>().allOrders;
    return Scaffold(
      appBar: AppBar(title: const Text('تقارير العمل')),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: allOrders.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _topWidget(context, allOrders);

                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      splashColor: AppColors.primaryColor,
                      onTap: onCardTap(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10),
                        child: childBuilder(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _topWidget(BuildContext context, List<OrderModel> allOrders) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomResponsiveRow(
        children: [
          Text(title, style: AppTextStyles.headLine24),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(data1, style: AppTextStyles.textStyle18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(data2, style: AppTextStyles.textStyle18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({super.key, required this.orderModel});

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
