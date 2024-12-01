import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/sold_products/product_orders_report/product_orders_report_list.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';
import '../../../sold_products/all_products_report_list_screen.dart';
import '../../../widgets/report_widget.dart';
import 'top_sold_product_short_report_card_data.dart';

class TopSoldProductsShortReport extends StatelessWidget {
  const TopSoldProductsShortReport({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductStats> productsStats =
        context.watch<DashboardCubit>().productStats;
    return ReportWidget(
      title: "افضل المنتجات",
      showAllOnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AllProductsReportListScreen(),
          ),
        );
      },
      itemCount: productsStats.length,
      onCardTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ProductOrdersReportList(productStats: productsStats[index])),
        );
      },
      childBuilder: (index) => TopSoldProductCardData(
        productStats: context.read<DashboardCubit>().productStats[index],
      ),
    );
  }
}
