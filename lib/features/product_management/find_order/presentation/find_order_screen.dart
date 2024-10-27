import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/components/product_details_card.dart';
import 'package:inventory_app/features/product_management/find_order/data/order_cubit/find_order_cubit.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/widgets/custom_card.dart';

class FindOrderScreen extends StatelessWidget {
  const FindOrderScreen({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("بيانات المنتج")),
      body: BlocProvider(
        create: (context) => FindOrderCubit("A538017300023120010"),
        child: const FindOrderBody(),
      ),
    );
  }
}

class FindOrderBody extends StatelessWidget {
  const FindOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FindOrderCubit, FindOrderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProductDetailsCard(productModel: ProductModel(), isOrder: true),
              CustomCard(
                child: Text("heloo"),
                title: "title",
              )
            ],
          ),
        );
      },
    );
  }
}
