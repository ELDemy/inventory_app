import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/di/injector.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import '../widgets/top_widget.dart';
import 'product_details_report_card.dart';

class AllProductsReportListScreen extends StatelessWidget {
  const AllProductsReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardCubit dashboardCubit = Injector.get<DashboardCubit>();
    return BlocProvider.value(
      value: dashboardCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقارير المنتجات')),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dashboardCubit.productStats.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _topWidget(dashboardCubit);
                    }
                    return ProductDetailsReportCard(
                      productStats: dashboardCubit.productStats[index - 1],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWidget(DashboardCubit dashboardCubit) {
    return TopWidget(
      title: 'كل المنتجات',
      children: [
        '${dashboardCubit.statistics.uniqueCustomers} عملاء',
        "${dashboardCubit.productStats.length} منتجات"
      ],
    );
  }
}
