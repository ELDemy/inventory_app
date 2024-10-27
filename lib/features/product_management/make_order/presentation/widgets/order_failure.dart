import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

class ProductFailureScreen extends StatelessWidget {
  const ProductFailureScreen({super.key, required this.errMsg});

  final String errMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errMsg,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<MakeOrderCubit>(context).fetchProduct();
            },
            child: const Text("اعادة المحاولة"),
          ),
          Text(BlocProvider.of<MakeOrderCubit>(context).barcode),
        ],
      ),
    );
  }
}
