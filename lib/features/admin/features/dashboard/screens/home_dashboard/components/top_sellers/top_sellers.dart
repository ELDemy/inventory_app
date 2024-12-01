import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';
import '../../../widgets/report_widget.dart';
import 'top_sellers_data.dart';

class TopSellers extends StatelessWidget {
  const TopSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<EmployeeStats> employeeStats =
        context.watch<DashboardCubit>().employeeStats;
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
