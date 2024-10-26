import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/data/cubit/product_management_cubit.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key, required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسليم عميل"),
      ),
      body: BlocProvider(
        create: (context) => ProductManagementCubit(),
        child: MakeOrderBody(barcode),
      ),
    );
  }
}

class MakeOrderBody extends StatelessWidget {
  const MakeOrderBody(this.barcode, {super.key});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagementCubit, ProductManagementState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Center();
      },
    );
  }
}
