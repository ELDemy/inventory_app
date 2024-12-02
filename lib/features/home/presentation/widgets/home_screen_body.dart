import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';

import 'categories_list.dart';
import 'product_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<ProductModel> products = context.watch<HomeCubit>().activeProducts;
        if (state is HomeInitial) {
          context.read<HomeCubit>().getProductModelsStream(context);
        }
        if (state is HomeLoading || state is HomeInitial) {
          return const MyCircularLoading();
        } else if (state is HomeProductsState) {
          return _homeContent(products);
        } else if (state is HomeSearchedProducts) {
          state.searchedProducts != null
              ? products = state.searchedProducts!
              : products;
          return _homeContent(products);
        } else if (state is HomeFailure) {
          return _failureScreen(context, state.errMsg);
        }
        return const Center(child: Text('حدث خطأ ما'));
      },
    );
  }

  FailureScreen _failureScreen(BuildContext context, String errMsg) {
    ShowInfoUtil.showMaterialBanner(context, msg: errMsg, isDismissible: true);
    return FailureScreen(
      errMsg: errMsg,
      onTap: () {
        context.read<HomeCubit>().getProductModelsStream(context);
      },
    );
  }

  Column _homeContent(List<ProductModel> products) {
    return Column(
      children: [
        const CategoriesList(),
        products.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              )
            : const Center(child: Text("لا يوجد منتجات"))
      ],
    );
  }
}
