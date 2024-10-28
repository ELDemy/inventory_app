import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/add_edit_product/data/add_edit_product_cubit/add_edit_product_cubit.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/widgets/product_form.dart';

class AddNewProductForm extends StatelessWidget {
  const AddNewProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEditProductCubit, AddEditProductState>(
      listener: (context, state) {
        if (state is AddEditProductLoading) {
          ShowInfoUtil.showLoadingDialog(context);
        } else if (state is AddEditProductSuccess) {
          Navigator.pop(context);
          ShowInfoUtil.showSnackBar(context, "تم اضافة المنتج بنجاح");
          Navigator.pop(context);
        } else if (state is AddEditProductFailure) {
          Navigator.pop(context);
          ShowInfoUtil.showSnackBar(context, state.errMsg);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("إضافة منتج جديد")),
        body: ProductForm(
          onSubmit: ({
            required formKey,
            required productNameController,
            required serialNumberController,
            required priceController,
            required quantityController,
            required powerController,
            required inputController,
            required outputController,
          }) {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<AddEditProductCubit>(context).addNewProduct(
                ProductModel(
                  serialNumber: serialNumberController.text,
                  productName: productNameController.text,
                  price: double.parse(priceController.text),
                  qty: int.parse(quantityController.text),
                  power: num.parse(powerController.text),
                  input: inputController.text,
                  output: outputController.text,
                ),
              );
            }
          },
          buttonText: "إضافة المنتج",
        ),
      ),
    );
  }
}
