import 'package:flutter/material.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/sellers/employee_orders_report.dart';
import 'package:inventory_app/features/admin/features/dashboard/screens/sellers/employees_list_report_screen.dart';

import '../../../../data/report_cubit/dashboard_cubit.dart';
import '../../../widgets/report_widget.dart';
import 'top_sellers_data.dart';

class TopSellers extends StatelessWidget {
  const TopSellers({super.key});

  @override
  Widget build(BuildContext context) {
    List<EmployeeStats> employeeStats =
        Injector.get<DashboardCubit>().employeesStats;
    return ReportWidget(
      height: 120,
      title: "اداء الموظفين",
      itemCount: employeeStats.length,
      showAllOnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EmployeesListReportScreen()),
        );
      },
      onCardTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                EmployeeOrdersReport(employeeStats: employeeStats[index]),
          ),
        );
      },
      childBuilder: (index) =>
          TopSellersData(employeeStats: employeeStats[index]),
    );
  }
}
