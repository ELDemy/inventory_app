import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/components/product_details_card.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/widgets/custom_card.dart';

class FindOrderScreen extends StatelessWidget {
  const FindOrderScreen({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("بيانات المنتج")),
      body: BlocProvider(
        create: (context) => MakeOrderCubit(barcode),
        child: Padding(
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
        ),
      ),
    );
  }
}
