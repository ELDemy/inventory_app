import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/edit_product_form.dart';
import 'package:inventory_app/features/product_management/product_profile/data/product_cubit/product_profile_cubit.dart';
import 'package:inventory_app/features/product_management/shared/components/product_details_card.dart';

class ProductProfileContent extends StatelessWidget {
  const ProductProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProfileCubit productCubit =
        BlocProvider.of<ProductProfileCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
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
                      child:
                          const Text("تعديل", style: TextStyle(fontSize: 20))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
