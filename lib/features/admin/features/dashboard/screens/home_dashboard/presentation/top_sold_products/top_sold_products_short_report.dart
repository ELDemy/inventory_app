import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

import '../helpers/report_widget.dart';
import '../order_history/order_history_short_report.dart';
import '../widgets/report_details_screen.dart';
import 'product_details_report_card.dart';
import 'top_sold_product_short_report_card_data.dart';

class TopSoldProductsShortReport extends StatelessWidget {
  const TopSoldProductsShortReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ProductStats> productsStats =
        context.watch<ReportCubit>().productStats;
    return ReportWidget(
      title: "افضل المنتجات",
      showAllOnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<ReportCubit>(),
              child: _buildAllProductsHistory(context),
            ),
          ),
        );
      },
      itemCount: productsStats.length,
      onCardTap: (index) {},
      childBuilder: (index) => TopSoldProductCardData(
        productStats: context.read<ReportCubit>().productStats[index],
      ),
    );
  }

  ReportDetailsScreen _buildAllProductsHistory(BuildContext context) {
    ReportCubit reportCubit = context.read<ReportCubit>();
    List<ProductStats> productStats = reportCubit.productStats;
    return ReportDetailsScreen(
      title: 'كل المنتجات',
      data1: "${reportCubit.statistics.totalRevenue} £E",
      data2: "${productStats.length}",
      itemCount: productStats.length,
      onCardTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: context.read<ReportCubit>(),
                child: AllOrdersHistoryList(
                    orders: productStats[index - 1].orders)),
          ),
        );
      },
      childBuilder: (index) =>
          ProductDetailsReportCard(productStats: productStats[index - 1]),
    );
  }
}
