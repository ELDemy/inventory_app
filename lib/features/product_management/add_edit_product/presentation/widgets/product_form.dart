import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_dropdown_button_form_field.dart';
import 'package:inventory_app/core/components/custom_serial_text_form_field.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/add_edit_product/data/add_edit_product_cubit/add_edit_product_cubit.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({
    super.key,
    this.productModel,
    required this.onSubmit,
    required this.buttonText,
    required this.categories,
    this.isUpdate = false,
  });

  final bool isUpdate;
  final List<String> categories;
  final String buttonText;
  final ProductModel? productModel;

  final void Function(GlobalKey<FormState> formKey, ProductModel productModel)
      onSubmit;

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

  ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    widget.categories.isNotEmpty
        ? selectedCategory.value = widget.categories[0]
        : selectedCategory;

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
                suffixIcon: const Icon(Icons.abc),
              ),
              if (!widget.isUpdate)
                CustomSerialTextFormField(controller: serialNumberController),
              ValueListenableBuilder<String?>(
                valueListenable: selectedCategory,
                builder: (context, category, child) {
                  return CategorySelectionField(
                    categories: widget.categories,
                    selectedCategory: category,
                    onCategorySelected: (category) {
                      selectedCategory.value = category;
                    },
                    onNewCategoryAdded: (newCategory) {
                      BlocProvider.of<AddEditProductCubit>(context)
                          .addNewCategory(newCategory);
                      widget.categories.add(newCategory);
                      selectedCategory.value = newCategory;
                    },
                  );
                },
              ),
              CustomTextFormField(
                labelText: "السعر",
                controller: priceController,
                isRequired: true,
                isNumbersOnly: true,
                suffixIcon: const Icon(Icons.attach_money_rounded),
              ),
              CustomTextFormField(
                labelText: "الكمية",
                controller: quantityController,
                isRequired: true,
                isNumbersOnly: true,
                suffixIcon: const Icon(Icons.inventory_2_outlined),
              ),
              CustomTextFormField(
                labelText: "Power",
                controller: powerController,
                suffixIcon: const Icon(Icons.bolt),
              ),
              CustomTextFormField(
                labelText: "Input",
                controller: inputController,
                suffixIcon: const Icon(Icons.south_east_rounded),
              ),
              CustomTextFormField(
                labelText: "Output",
                controller: outputController,
                suffixIcon: const Icon(Icons.north_west_rounded),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => widget.onSubmit(
                  formKey,
                  ProductModel(
                    serialNumber: serialNumberController.text,
                    productName: productNameController.text,
                    category: selectedCategory.value,
                    price: double.parse(priceController.text),
                    qty: int.parse(quantityController.text),
                    power: powerController.text,
                    input: inputController.text,
                    output: outputController.text,
                  ),
                ),
                child: Text(widget.buttonText,
                    style: const TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
