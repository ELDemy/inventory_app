import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import '../widgets/top_info_card.dart';
import 'product_details_report_card.dart';

class AllProductsReportDetailsScreen extends StatelessWidget {
  const AllProductsReportDetailsScreen({super.key, required this.reportCubit});
  final DashboardCubit reportCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: reportCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقارير العمل')),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: reportCubit.productStats.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) return _topWidget(context);
                    return ProductDetailsReportCard(
                      reportCubit: reportCubit,
                      productStats: reportCubit.productStats[index - 1],
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

  Padding _topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomResponsiveRow(
        children: [
          const Text('كل المنتجات', style: AppTextStyles.headLine24),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  TopInfoCard(
                    content: '${reportCubit.statistics.uniqueCustomers} عملاء',
                  ),
                  TopInfoCard(
                    content: "${reportCubit.productStats.length} منتجات",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
