import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/admin/features/dashboard/data/report_cubit/dashboard_cubit.dart';

class DashboardDateRangePicker extends StatelessWidget {
  const DashboardDateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final DashboardCubit dashboardCubit = context.watch<DashboardCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: CustomResponsiveRow(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildDatePickerButton(
                    context,
                    label: 'من',
                    date: dashboardCubit.startDate,
                    onDateSelected: (selectedDate) {
                      dashboardCubit.setStartDate(selectedDate);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(":", style: TextStyle(fontSize: 20)),
                  ),
                  _buildDatePickerButton(
                    context,
                    label: 'الى',
                    date: dashboardCubit.endDate,
                    onDateSelected: (selectedDate) {
                      dashboardCubit.setEndDate(selectedDate);
                    },
                  ),
                ],
              ),
              Card(
                color: AppColors.primaryColor,
                child: InkWell(
                  onTap: () {
                    if (dashboardCubit.startDate
                        .isAfter(dashboardCubit.endDate)) {
                      ShowInfoUtil.showSnackBar(context,
                          'تاريخ البداية يجب أن يكون قبل تاريخ النهاية');
                      return;
                    }
                    dashboardCubit.getAllOrders();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20),
                    child: Text(
                      "بحث",
                      style: AppTextStyles.textStyle16.copyWith(),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDatePickerButton(
    BuildContext context, {
    required String label,
    required DateTime date,
    required Function(DateTime) onDateSelected,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime(2050),
          );

          if (picked != null && picked != date) {
            onDateSelected(picked);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Text(
            DateFormat('yyyy/MM/dd').format(date),
            style: AppTextStyles.textStyle16,
          ),
        ),
      ),
    );
  }
}
