import 'package:flutter/material.dart';

import 'components/orders_history/order_history_short_report.dart';
import 'components/top_sellers/top_sellers.dart';
import 'components/top_sold_products/top_sold_products_short_report.dart';
import 'components/total_revenue_card.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalRevenueCard(),
              SizedBox(height: 10),
              TopSoldProductsShortReport(),
              TopSellers(),
              OrdersHistoryShortReport(),
            ],
          ),
        ),
      ),
    );
  }
}
