import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/product_screen/data/product_cubit/product_cubit.dart';

import 'product_content.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.identifierSN});

  final String identifierSN;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(identifierSN),
      child: BlocConsumer<ProductCubit, ProductState>(
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
          if (state is ProductInitial || state is ProductLoading) {
            bodyContent = const MyCircularLoading();
          } else if (state is ProductSuccess || state is DeleteProductState) {
            bodyContent = const ProductContent();
          } else if (state is ProductFailure) {
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
                      BlocProvider.of<ProductCubit>(context).deleteProduct();
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

  FailureScreen _failureScreen(ProductFailure state, BuildContext context) {
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);
    return FailureScreen(
      errMsg: state.errMsg,
      bottomText: productCubit.identifierSN,
      onTap: () => productCubit.fetchProduct(),
    );
  }
}
