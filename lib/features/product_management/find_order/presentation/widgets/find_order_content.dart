import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/date_extension.dart';
import 'package:inventory_app/features/product_management/find_order/data/order_cubit/find_order_cubit.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/widgets/custom_card.dart';
import 'package:inventory_app/features/product_management/shared/components/card_detail_row.dart';
import 'package:inventory_app/features/product_management/shared/components/product_details_card.dart';

class FindOrderContent extends StatelessWidget {
  const FindOrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = BlocProvider.of<FindOrderCubit>(context).orderModel;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsCard(productModel: orderModel.product, isOrder: true),
            _clientCard(orderModel),
            _orderDetailsCard(orderModel),
          ],
        ),
      ),
    );
  }

  CustomCard _orderDetailsCard(OrderModel orderModel) {
    return CustomCard(
      title: "التفاصيل",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardDetailRow(
            label: "تاريخ العمليه :",
            content: orderModel.creationTime?.dayFormat() ?? "",
            iconData: Icons.date_range_rounded,
          ),
          CardDetailRow(
            label: "المسئول :",
            content: orderModel.employee ?? "###",
            iconData: Icons.person,
          ),
          CardDetailRow(
            label: "سعر البيع :",
            content: orderModel.price.toString(),
            iconData: Icons.attach_money_rounded,
          ),
          CardDetailRow(
            label: "الكمية :",
            content: orderModel.quantity.toString(),
            iconData: Icons.numbers_rounded,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
              child: Column(
                children: [
                  ...orderModel.serialNumbers.map(
                    (barcode) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(barcode)],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomCard _clientCard(OrderModel orderModel) {
    return CustomCard(
      title: "بيانات العميل",
      iconData: Icons.person,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardDetailRow(
            label: "اسم العميل :",
            content: orderModel.clientName ?? "--",
            iconData: Icons.person,
          ),
          CardDetailRow(
            label: "رقم الموبايل :",
            content: orderModel.clientPhoneNumber ?? "--",
            iconData: Icons.numbers_sharp,
          ),
          CardDetailRow(
            label: "نوع العميل :",
            content: orderModel.clientType ?? "--",
            iconData: Icons.person,
          ),
        ],
      ),
    );
  }
}
