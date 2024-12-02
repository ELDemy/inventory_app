import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/order_history/order_details_report_card.dart';
import 'package:inventory_app/features/product_management/find_order/presentation/find_order_screen.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import '../widgets/orders_report_list.dart';
import '../widgets/top_widget.dart';

class EmployeeOrdersReport extends StatelessWidget {
  const EmployeeOrdersReport({super.key, required this.employeeStats});
  final EmployeeStats employeeStats;

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = employeeStats.orders;
    return BlocProvider.value(
      value: Injector.get<DashboardCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(employeeStats.employeeName)),
        body: OrdersReportList(
          itemCount: orders.length,
          topWidget: _topWidget(orders),
          onCardTap: (index) {
            _onCardTap(context, index, orders[index].serialNumbers.first);
          },
          childBuilder: (index) =>
              OrderDetailsReportCard(orderModel: orders[index]),
        ),
      ),
    );
  }

  TopWidget _topWidget(List<OrderModel> orders) {
    return TopWidget(
      children: [
        "${employeeStats.totalUnits} وحدة",
        "${orders.length} طلبات",
      ],
      title: 'الطلبات',
    );
  }

  _onCardTap(BuildContext context, index, String barcode) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FindOrderScreen(barcode: barcode)),
    );
  }
}
