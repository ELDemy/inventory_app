import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/features/product_management/product_screen/data/product_cubit/product_cubit.dart';

import 'product_content.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial || state is ProductLoading) {
          return const MyCircularLoading();
        } else if (state is ProductSuccess) {
          return const ProductContent();
        } else if (state is ProductFailure) {
          return _failureScreen(state, context);
        } else {
          return const Center(
            child: Text("خطأ برجاء المحاوله مره اخرى!!! "),
          ); //this shouldn't happen
        }
      },
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
