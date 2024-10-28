import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/add_new_product/data/add_new_product_cubit/add_new_product_cubit.dart';
import 'package:inventory_app/features/product_management/components/product_form.dart';

class EditProductForm extends StatelessWidget {
  const EditProductForm({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل المنتج")),
      body: BlocProvider(
        create: (context) => AddNewProductCubit(),
        child: BlocBuilder<AddNewProductCubit, AddNewProductState>(
          builder: (context, state) => ProductForm(
            isUpdate: true,
            productModel: productModel,
            buttonText: "تعديل المنتج",
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
                BlocProvider.of<AddNewProductCubit>(context)
                    .updateProduct(ProductModel(
                  serialNumber: serialNumberController.text,
                  productName: productNameController.text,
                  price: double.parse(priceController.text),
                  qty: int.parse(quantityController.text),
                  power: num.parse(powerController.text),
                  input: inputController.text,
                  output: outputController.text,
                ));
                print(productModel.identifierSN);
              }
            },
          ),
        ),
      ),
    );
  }
}
