import 'package:flutter/material.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/presentation/widgets/order_history/order_history_data.dart';

import '../helpers/report_widget.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ReportWidget(
      height: 160,
      title: "الطلبات",
      showAllOnTap: () {},
      childBuilder: (index) => OrderHistoryData(index: index),
    );
  }
}
