import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/order_history/order_details_report_card.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/widgets/orders_report_list.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/widgets/top_widget.dart';
import 'package:inventory_app/features/product_management/find_order/presentation/find_order_screen.dart';
import 'package:inventory_app/features/product_management/shared/components/product_details_card.dart';

import '../../../data/report_cubit/dashboard_cubit.dart';

class ProductOrdersReportList extends StatelessWidget {
  const ProductOrdersReportList({super.key, required this.productStats});

  final ProductStats productStats;
  @override
  Widget build(BuildContext context) {
    DashboardCubit dashboardCubit = Injector.get<DashboardCubit>();
    List<OrderModel> orders = dashboardCubit.allOrders;
    return BlocProvider.value(
      value: Injector.get<DashboardCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تقرير منتج')),
        body: Column(
          children: [
            Expanded(
              child: OrdersReportList(
                topWidget: _topWidget(dashboardCubit),
                itemCount: productStats.orders.length,
                onCardTap: (index) {
                  _onCardTap(context, index, orders[index].serialNumbers.first);
                },
                childBuilder: (index) => OrderDetailsReportCard(
                    orderModel: productStats.orders[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topWidget(DashboardCubit dashboardCubit) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ProductDetailsCard(productModel: productStats.productModel),
        ),
        TopWidget(
          title: 'الطلبات',
          children: [
            "${productStats.uniqueClients.length} عملاء",
            "${productStats.orders.length} طلبات",
            "${productStats.totalUnits} وحدة",
          ],
        ),
      ],
    );
  }

  _onCardTap(BuildContext context, index, String barcode) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FindOrderScreen(barcode: barcode)));
  }
}
