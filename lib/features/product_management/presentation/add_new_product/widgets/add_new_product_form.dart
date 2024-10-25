import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/data/cubit/add_new_product_cubit.dart';
import 'package:inventory_app/features/product_management/presentation/components/custom_serial_text_form_field.dart';
import 'package:inventory_app/features/product_management/presentation/components/custom_text_form_field.dart';

class AddNewProductForm extends StatefulWidget {
  const AddNewProductForm({super.key});

  @override
  State<AddNewProductForm> createState() => _AddNewProductFormState();
}

class _AddNewProductFormState extends State<AddNewProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _powerController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _serialNumberController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _powerController.dispose();
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddNewProductLoading) {
          ShowInfoUtil.hideCurrentMaterialBanner(context);
          ScaffoldMessenger.of(context).showMaterialBanner(
            ShowInfoUtil.loadingBanner(),
          );
        } else if (state is AddNewProductSuccess) {
          ShowInfoUtil.hideCurrentMaterialBanner(context);
          ShowInfoUtil.showSnackBar(context, "تم اضافة المنتج بنجاح");
          _clearControllers();
        } else if (state is AddNewProductFailure) {
          ShowInfoUtil.hideCurrentMaterialBanner(context);
          ShowInfoUtil.showSnackBar(context, state.errMsg);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("إضافة منتج جديد")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "اسم المنتج",
                    controller: _productNameController,
                    isRequired: true,
                  ),
                  CustomSerialTextFormField(
                    controller: _serialNumberController,
                  ),
                  CustomTextFormField(
                    labelText: "السعر",
                    controller: _priceController,
                    isRequired: true,
                    isNumbersOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: "الكمية",
                    controller: _quantityController,
                    isRequired: true,
                    isNumbersOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: "Power",
                    controller: _powerController,
                    isRequired: true,
                    isNumbersOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: "Input",
                    controller: _inputController,
                    isRequired: true,
                  ),
                  CustomTextFormField(
                    labelText: "Output",
                    controller: _outputController,
                    isRequired: true,
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text("إضافة المنتج"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<AddNewProductCubit>(context).addNewProduct(
        ProductModel(
          serialNumber: _serialNumberController.text,
          productName: _productNameController.text,
          price: double.parse(_priceController.text),
          qty: int.parse(_quantityController.text),
          power: num.parse(_powerController.text),
          input: _inputController.text,
          output: _outputController.text,
        ),
      );
    }
  }

  void _clearControllers() {
    _productNameController.clear();
    _serialNumberController.clear();
    _priceController.clear();
    _quantityController.clear();
    _powerController.clear();
    _inputController.clear();
    _outputController.clear();
  }
}
