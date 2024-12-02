import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/di/injector.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import '../widgets/top_widget.dart';
import 'employee_details_card_report_card.dart';

class EmployeesListReportScreen extends StatelessWidget {
  const EmployeesListReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardCubit dashboardCubit = Injector.get<DashboardCubit>();
    return BlocProvider.value(
      value: dashboardCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقرير الموظفين')),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dashboardCubit.employeesStats.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) return _topWidget(dashboardCubit);

                    return EmployeeDetailsCardReportCard(
                      employeeStats: dashboardCubit.employeesStats[index - 1],
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
      title: 'البائعون',
      children: [
        '${dashboardCubit.statistics.uniqueCustomers} عميل',
        '${dashboardCubit.statistics.totalUnits} وحدة',
        "${dashboardCubit.employeesStats.length} بائعين"
      ],
    );
  }
}
