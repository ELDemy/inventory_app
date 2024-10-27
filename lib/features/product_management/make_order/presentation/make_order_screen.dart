import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'widgets/make_order_body.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسليم طلب"),
      ),
      body: BlocProvider(
        create: (context) => MakeOrderCubit(barcode),
        child: const MakeOrderBody(),
      ),
    );
  }
}
