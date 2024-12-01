import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';
import '../../../sold_products/all_products_report_details_screen.dart';
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
            builder: (_) => AllProductsReportDetailsScreen(
              reportCubit: context.read<DashboardCubit>(),
            ),
          ),
        );
      },
      itemCount: productsStats.length,
      onCardTap: (index) {},
      childBuilder: (index) => TopSoldProductCardData(
        productStats: context.read<DashboardCubit>().productStats[index],
      ),
    );
  }
}
