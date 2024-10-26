import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/features/product_management/data/cubit/product_management_cubit.dart';

import 'order_failure.dart';

class MakeOrderBody extends StatefulWidget {
  const MakeOrderBody(this.barcode, {super.key});

  final String barcode;

  @override
  State<MakeOrderBody> createState() => _MakeOrderBodyState();
}

class _MakeOrderBodyState extends State<MakeOrderBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductManagementCubit>(context).getProduct(widget.barcode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagementCubit, ProductManagementState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          ProductModel productModel = state.productModel;
          return Center(
              child: Column(children: [Text(productModel.productName ?? "")]));
        } else if (state is ProductLoading) {
          return _circularProgress();
        } else if (state is ProductFailure) {
          return OrderFailure(barcode: widget.barcode, errMsg: state.errMsg);
        } else {
          return const Center(child: Text("!!!")); //this shouldn't happen
        }
      },
    );
  }

  Center _circularProgress() {
    return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor));
  }
}
