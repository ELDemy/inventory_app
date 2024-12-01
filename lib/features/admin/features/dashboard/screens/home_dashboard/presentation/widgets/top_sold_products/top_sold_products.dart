import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

import '../helpers/report_widget.dart';
import 'top_sold_product_card_data.dart';

class TopSoldProducts extends StatelessWidget {
  const TopSoldProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ProductStats> productsStats =
        context.watch<ReportCubit>().productStats;
    return ReportWidget(
      title: "افضل المنتجات",
      showAllOnTap: () {},
      itemCount: productsStats.length,
      onCardTap: (index) {},
      childBuilder: (index) => TopSoldProductCardData(
        productStats: context.read<ReportCubit>().productStats[index],
      ),
    );
  }
}
