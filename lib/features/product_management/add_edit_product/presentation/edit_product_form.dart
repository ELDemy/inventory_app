import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/add_edit_product/data/add_edit_product_cubit/add_edit_product_cubit.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/widgets/product_form.dart';
import 'package:inventory_app/features/product_management/product_profile/data/product_cubit/product_profile_cubit.dart';

class EditProductForm extends StatelessWidget {
  const EditProductForm(
      {super.key,
      required this.productModel,
      required this.productProfileCubit});

  final ProductModel productModel;
  final ProductProfileCubit productProfileCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل المنتج")),
      body: BlocProvider(
        create: (context) => AddEditProductCubit(),
        child: BlocConsumer<AddEditProductCubit, AddEditProductState>(
          listener: (context, state) {
            if (state is AddEditProductLoading) {
              ShowInfoUtil.showLoadingDialog(context);
            } else if (state is AddEditProductSuccess) {
              Navigator.pop(context);
              ShowInfoUtil.showSnackBar(context, "تم تعديل المنتج بنجاح");
              Navigator.pop(context);
            } else if (state is AddEditProductFailure) {
              Navigator.pop(context);
              ShowInfoUtil.showSnackBar(context, state.errMsg);
            }
          },
          builder: (context, state) => ProductForm(
            defaultCategory: productModel.category,
            buttonText: "تعديل المنتج",
            isUpdate: true,
            productModel: productModel,
            onSubmit: (productModel) async {
              await BlocProvider.of<AddEditProductCubit>(context)
                  .updateProduct(productModel);
              await productProfileCubit.fetchProduct();
            },
          ),
        ),
      ),
    );
  }
}
