import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/find_order/data/order_cubit/find_order_cubit.dart';

import 'widgets/find_order_body.dart';

class FindOrderScreen extends StatelessWidget {
  const FindOrderScreen({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("بيانات المنتج")),
      body: BlocProvider(
        create: (context) => FindOrderCubit("-1"),
        child: const FindOrderBody(),
      ),
    );
  }
}
