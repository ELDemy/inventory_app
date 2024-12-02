import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/di/injector.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import 'dashboard_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.register<DashboardCubit>(DashboardCubit()),
      child: Scaffold(
        appBar: AppBar(title: const Text('تقارير العمل')),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardFailure) {
              return _failureScreen(state, context);
            } else if (state is DashboardSuccess) {
              return const DashboardContent();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  FailureScreen _failureScreen(DashboardFailure state, BuildContext context) {
    return FailureScreen(
      errMsg: state.errMsg,
      onTap: () => context.read<DashboardCubit>().getAllOrders(),
    );
  }
}
