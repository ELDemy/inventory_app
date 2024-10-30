import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/my_citcular_loading.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/home/data/cubit/home_cubit.dart';

import 'product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is InternetState) {
          state.connectionBanner(context);
        } else if (state is HomeFailure) {
          ShowInfoUtil.showMaterialBanner(context,
              msg: state.errMsg, isDismissible: true);
        }
      },
      builder: (context, state) {
        List<ProductModel> products = context.watch<HomeCubit>().products;
        if (state is HomeInitial) {
          context.read<HomeCubit>().getProductModelsStream(context);
        }
        if (state is HomeLoading || state is HomeInitial) {
          return const MyCircularLoading();
        } else if (state is HomeSearchedProducts &&
            state.searchedProducts != null) {
          products = state.searchedProducts!;
        }

        return products.isNotEmpty
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              )
            : const Center(child: Text("لا يوجد منتجات"));
      },
    );
  }
}
