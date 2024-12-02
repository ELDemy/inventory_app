import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_circular_loading.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'make_order_content.dart';

class MakeOrderBody extends StatelessWidget {
  const MakeOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeOrderCubit, MakeOrderState>(
      listener: (context, state) {
        if (state is MakeOrderLoading) {
          ShowInfoUtil.showLoadingDialog(context);
        } else if (state is MakeOrderSuccess) {
          Navigator.pop(context);
          ShowInfoUtil.showSnackBar(context, "تمت العمليه بنجاح");
          Navigator.pop(context);
        } else if (state is MakeOrderFailure) {
          Navigator.pop(context);
          ShowInfoUtil.showMaterialBanner(context,
              msg: state.errMsg, isDismissible: true);
        }
      },
      builder: (context, state) {
        if (state is FetchProductLoading || state is MakeOrderInitial) {
          return const MyCircularLoading();
        } else if (state is FetchProductLoaded || state is MakingOrderState) {
          return const MakeOrderContent();
        } else if (state is FetchProductFailure) {
          return _failureScreen(state, context);
        } else {
          return const Center(
            child: Text("خطأ برجاء المحاوله مره اخرى!!! "),
          ); //this shouldn't happen
        }
      },
    );
  }

  FailureScreen _failureScreen(
      FetchProductFailure state, BuildContext context) {
    MakeOrderCubit makeOrderCubit = BlocProvider.of<MakeOrderCubit>(context);
    return FailureScreen(
      errMsg: state.errMsg,
      bottomText: makeOrderCubit.barcode,
      onTap: () => makeOrderCubit.fetchProduct(),
    );
  }
}
