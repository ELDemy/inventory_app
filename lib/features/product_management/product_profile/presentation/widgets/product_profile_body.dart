import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_circular_loading.dart';
import 'package:inventory_app/features/product_management/product_profile/data/product_cubit/product_profile_cubit.dart';

import 'product_profile_content.dart';

class ProductProfileBody extends StatelessWidget {
  const ProductProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductProfileCubit, ProductProfileState>(
      builder: (context, state) {
        if (state is ProductProfileInitial || state is ProductProfileLoading) {
          return const MyCircularLoading();
        } else if (state is ProductProfileSuccess) {
          return const ProductProfileContent();
        } else if (state is ProductProfileFailure) {
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
