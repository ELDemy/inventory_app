import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/product_profile/data/product_cubit/product_profile_cubit.dart';

import 'widgets/product_profile_content.dart';

class ProductProfileScreen extends StatelessWidget {
  const ProductProfileScreen({super.key, required this.identifierSN});

  final String identifierSN;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductProfileCubit(identifierSN),
      child: BlocConsumer<ProductProfileCubit, ProductProfileState>(
        listener: (context, state) {
          if (state is DeleteProductLoading) {
            ShowInfoUtil.showLoadingDialog(context);
          } else if (state is DeleteProductSuccess) {
            Navigator.pop(context);
            ShowInfoUtil.showSnackBar(context, "تم حذف المنتج");
            Navigator.pop(context);
          } else if (state is DeleteProductFailure) {
            Navigator.pop(context);
            ShowInfoUtil.showSnackBar(
                context, "حدث خطأ ! يرجى المحاوله مرة اخرى");
          }
        },
        builder: (context, state) {
          Widget bodyContent;
          if (state is ProductProfileInitial ||
              state is ProductProfileLoading) {
            bodyContent = const MyCircularLoading();
          } else if (state is ProductProfileSuccess ||
              state is DeleteProductState) {
            bodyContent = const ProductProfileContent();
          } else if (state is ProductProfileFailure) {
            bodyContent = _failureScreen(state, context);
          } else {
            bodyContent = const Center(
              child: Text("خطأ برجاء المحاوله مره اخرى!!! "),
            ); //this shouldn't happen
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("بيانات المنتج"),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductProfileCubit>(context)
                          .deleteProduct();
                    },
                    icon: const Icon(Icons.delete_outline_rounded, size: 30))
              ],
            ),
            body: bodyContent,
          );
        },
      ),
    );
  }

  FailureScreen _failureScreen(
      ProductProfileFailure state, BuildContext context) {
    ProductProfileCubit productCubit =
        BlocProvider.of<ProductProfileCubit>(context);
    return FailureScreen(
      errMsg: state.errMsg,
      bottomText: productCubit.identifierSN,
      onTap: () => productCubit.fetchProduct(),
    );
  }
}
