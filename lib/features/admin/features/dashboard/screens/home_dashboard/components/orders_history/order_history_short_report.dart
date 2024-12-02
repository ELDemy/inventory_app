import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/features/product_management/find_order/presentation/find_order_screen.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';
import '../../../order_history/all_orders_report_details_screen.dart';
import '../../../widgets/report_widget.dart';
import 'order_history_short_report_data.dart';

class OrdersHistoryShortReport extends StatelessWidget {
  const OrdersHistoryShortReport({super.key});

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = context.watch<DashboardCubit>().allOrders;
    return ReportWidget(
      height: 160,
      title: "الطلبات",
      itemCount: orders.length,
      showAllOnTap: () {
        // generateFakeOrders(200);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AllOrdersReportDetailsScreen(),
          ),
        );
      },
      onCardTap: (index) {
        _onCardTap(context, index, orders[index].serialNumbers.first);
      },
      childBuilder: (index) => ShortOrderHistoryData(orderModel: orders[index]),
    );
  }

  _onCardTap(BuildContext context, index, String barcode) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FindOrderScreen(barcode: barcode)));
  }
}
