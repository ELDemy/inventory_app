import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/components/custom_text_form_field.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_functions/data/add_product_cubit/add_new_product_cubit.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddNewProductLoading) {
          ShowInfoUtil.hideCurrentMaterialBanner(context);
          ScaffoldMessenger.of(context).showMaterialBanner(
            ShowInfoUtil.loadingBanner(),
          );
        }
        if (state is AddNewProductSuccess) {
          // ShowInfoUtil.hideCurrentMaterialBanner(context);
          _clearControllers();
        } else {
          // ShowInfoUtil.hideCurrentMaterialBanner(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("اضافة منتج جديد")),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "اسم المنتج",
                    controller: productNameController,
                    isRequired: true,
                  ),
                  CustomTextFormField(
                    labelText: "الرقم التسلسلي",
                    controller: serialNumberController,
                    isRequired: true,
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
                  ),
                  CustomTextFormField(
                    labelText: "السعر",
                    controller: priceController,
                    isRequired: true,
                    isNumbersOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: "Power",
                    controller: powerController,
                    isRequired: true,
                    isNumbersOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: "Input",
                    controller: inputController,
                    isRequired: true,
                  ),
                  CustomTextFormField(
                    labelText: "Output",
                    controller: outputController,
                    isRequired: true,
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<AddNewProductCubit>(context)
                          .emitLoading();
                      return;
                      if (formKey.currentState!.validate()) {
                        try {
                          await BlocProvider.of<AddNewProductCubit>(context)
                              .addNewProduct(
                            ProductModel(
                              serialNumber: serialNumberController.text,
                              productName: productNameController.text,
                              price: double.parse(priceController.text),
                              power: num.parse(powerController.text),
                              input: inputController.text,
                              output: outputController.text,
                            ),
                          );
                        } on Exception catch (e) {
                          // TODO
                        }
                      }
                    },
                    child: Text("Test Form"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearControllers() {
    serialNumberController.clear();
    productNameController.clear();
    priceController.clear();
    powerController.clear();
    inputController.clear();
    outputController.clear();
  }
}
