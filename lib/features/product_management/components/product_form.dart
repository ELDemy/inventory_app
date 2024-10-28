import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custom_serial_text_form_field.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/models/product_model.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({
    super.key,
    this.productModel,
    required this.onSubmit,
    required this.buttonText,
    this.isUpdate = false,
  });
  final bool isUpdate;

  final ProductModel? productModel;
  final void Function({
    required GlobalKey<FormState> formKey,
    required TextEditingController productNameController,
    required TextEditingController serialNumberController,
    required TextEditingController priceController,
    required TextEditingController quantityController,
    required TextEditingController powerController,
    required TextEditingController inputController,
    required TextEditingController outputController,
  }) onSubmit;
  final String buttonText;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.productModel != null) {
      productNameController.text = widget.productModel!.productName ?? "";
      serialNumberController.text =
          widget.productModel!.identifierSN?.toString() ?? "";
      priceController.text = widget.productModel!.price.toString();
      powerController.text = widget.productModel!.power?.toString() ?? "";
      inputController.text = widget.productModel!.input ?? "";
      outputController.text = widget.productModel!.output?.toString() ?? "";
      quantityController.text = widget.productModel!.qty.toString();
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    serialNumberController.dispose();
    priceController.dispose();
    quantityController.dispose();
    powerController.dispose();
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "اسم المنتج",
                controller: productNameController,
                isRequired: true,
              ),
              if (!widget.isUpdate)
                CustomSerialTextFormField(
                  controller: serialNumberController,
                ),
              CustomTextFormField(
                labelText: "السعر",
                controller: priceController,
                isRequired: true,
                isNumbersOnly: true,
              ),
              CustomTextFormField(
                labelText: "الكمية",
                controller: quantityController,
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => widget.onSubmit(
                  formKey: formKey,
                  productNameController: productNameController,
                  serialNumberController: serialNumberController,
                  priceController: priceController,
                  quantityController: quantityController,
                  powerController: powerController,
                  inputController: inputController,
                  outputController: outputController,
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
