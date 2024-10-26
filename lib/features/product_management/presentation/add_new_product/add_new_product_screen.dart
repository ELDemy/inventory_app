import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/features/product_management/data/cubit/product_management_cubit.dart';

import 'widgets/add_new_product_form.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductManagementCubit(),
      child: const AddNewProductForm(),
    );
  }
}
