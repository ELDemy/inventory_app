import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'order_content.dart';
import 'order_failure.dart';

class MakeOrderBody extends StatelessWidget {
  const MakeOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MakeOrderCubit, MakeOrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          return const OrderContent();
        } else if (state is OrderLoading && state is MakeOrderInitial) {
          return _circularProgress();
        } else if (state is OrderFailure) {
          return OrderFailureScreen(errMsg: state.errMsg);
        } else {
          return const Center(child: Text("!!!")); //this shouldn't happen
        }
      },
    );
  }

  Center _circularProgress() {
    return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor));
  }
}
