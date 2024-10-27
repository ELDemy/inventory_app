import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import '../../../components/product_details_card.dart';
import 'make_order_form.dart';

class MakeOrderContent extends StatelessWidget {
  const MakeOrderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ProductDetailsCard(
                productModel:
                    BlocProvider.of<MakeOrderCubit>(context).productModel),
            const MakeOrderForm(),
          ],
        ),
      ),
    );
  }
}
