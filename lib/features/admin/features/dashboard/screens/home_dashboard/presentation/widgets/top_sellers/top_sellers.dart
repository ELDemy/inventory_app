import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/home_dashboard/data/report_cubit/report_cubit.dart';

import '../helpers/report_widget.dart';
import 'top_sellers_data.dart';

class TopSellers extends StatelessWidget {
  const TopSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<EmployeeStats> employeeStats =
        context.watch<ReportCubit>().employeeStats;
    return ReportWidget(
      height: 120,
      title: "اداء الموظفين",
      showAllOnTap: () {},
      itemCount: employeeStats.length,
      onCardTap: (index) {},
      childBuilder: (index) =>
          TopSellersData(employeeStats: employeeStats[index]),
    );
  }
}
