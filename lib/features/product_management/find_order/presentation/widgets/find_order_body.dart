import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/features/product_management/find_order/data/order_cubit/find_order_cubit.dart';

import 'find_order_content.dart';

class FindOrderBody extends StatelessWidget {
  const FindOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindOrderCubit, FindOrderState>(
      builder: (context, state) {
        if (state is FindOrderInitial || state is FindOrderLoading) {
          return const MyCircularLoading();
        } else if (state is FindOrderSuccess) {
          return const FindOrderContent();
        } else if (state is FindOrderFailure) {
          return _failureScreen(state, context);
        } else {
          return const Center(child: Text("خطأ برجاء المحاوله مره اخرى!!! "));
        }
      },
    );
  }

  FailureScreen _failureScreen(FindOrderFailure state, BuildContext context) {
    FindOrderCubit findOrderCubit = BlocProvider.of<FindOrderCubit>(context);
    return FailureScreen(
      errMsg: state.errMsg,
      bottomText: BarcodeUtil.parseIdentifierFromSN(findOrderCubit.barcode),
      onTap: () => findOrderCubit.fetchOrder(),
    );
  }
}
