import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'order_content.dart';
import 'order_failure.dart';

class MakeOrderBody extends StatelessWidget {
  const MakeOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeOrderCubit, MakeOrderState>(
      listener: (context, state) {
        if (state is OrderLoading) {
          ShowInfoUtil.showLoadingMaterialBanner(context);
        } else if (state is OrderSuccess) {
          ShowInfoUtil.hideCurrentMaterialBanner(context);
          ShowInfoUtil.showSnackBar(context, "تمت العمليه بنجاح");
          Navigator.pop(context);
        } else if (state is OrderFailure) {
          ShowInfoUtil.showMaterialBanner(context,
              msg: state.errMsg, isDismissible: true);
        }
      },
      builder: (context, state) {
        if (state is ProductLoading || state is MakeOrderInitial) {
          return _circularProgress();
        } else if (state is ProductLoaded || state is MakingOrderState) {
          return const OrderContent();
        } else if (state is ProductFailure) {
          return ProductFailureScreen(errMsg: state.errMsg);
        } else {
          return const Center(
            child: Text("خطأ برجاء المحاوله مره اخرى!!! "),
          ); //this shouldn't happen
        }
      },
    );
  }

  Center _circularProgress() {
    return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor));
  }
}
