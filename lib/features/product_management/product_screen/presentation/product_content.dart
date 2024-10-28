import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/components/product_details_card.dart';
import 'package:inventory_app/features/product_management/edit_product/presentation/edit_product_form.dart';
import 'package:inventory_app/features/product_management/product_screen/data/product_cubit/product_cubit.dart';

class ProductContent extends StatelessWidget {
  const ProductContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          ProductDetailsCard(productModel: productCubit.productModel),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProductForm(
                                productModel: productCubit.productModel)),
                      );
                    },
                    child: const Text("تعديل", style: TextStyle(fontSize: 20))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
