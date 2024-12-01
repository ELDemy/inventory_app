import 'package:flutter/material.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/widgets/report_details_card.dart';

class OrdersReportList extends StatelessWidget {
  const OrdersReportList({
    super.key,
    required this.itemCount,
    required this.topWidget,
    required this.onCardTap,
    required this.childBuilder,
  });

  final int itemCount;
  final Widget topWidget;
  final Function(int index) onCardTap;
  final Widget Function(int index) childBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemCount + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return topWidget;
                }

                return ReportDetailsCard(
                  onCardTap: () {
                    onCardTap(index);
                  },
                  child: childBuilder(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
