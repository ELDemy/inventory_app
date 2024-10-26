import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/data/cubit/product_management_cubit.dart';

class OrderFailure extends StatelessWidget {
  const OrderFailure({
    super.key,
    required this.barcode,
    required this.errMsg,
  });

  final String barcode;
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
              BlocProvider.of<ProductManagementCubit>(context)
                  .getProduct(barcode);
            },
            child: const Text("اعادة المحاولة"),
          ),
          Text(barcode),
        ],
      ),
    );
  }
}
