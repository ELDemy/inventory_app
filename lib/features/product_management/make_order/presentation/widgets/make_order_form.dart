import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_dropdown_button_form_field.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'custom_card.dart';
import 'make_order_details_form.dart';

class MakeOrderForm extends StatefulWidget {
  const MakeOrderForm({super.key});

  @override
  State<MakeOrderForm> createState() => _MakeOrderFormState();
}

class _MakeOrderFormState extends State<MakeOrderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientNumberController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  ValueNotifier<String> clientType = ValueNotifier('تاجر');

  final List<String> barcodes = [];

  @override
  void dispose() {
    _clientNameController.dispose();
    _clientNumberController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MakeOrderCubit orderCubit = BlocProvider.of<MakeOrderCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomCard(
            title: "بيانات العميل",
            iconData: Icons.person,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "اسم العميل",
                  suffixIcon: const Icon(Icons.person),
                  controller: _clientNameController,
                ),
                CustomTextFormField(
                  labelText: "رقم الموبايل",
                  suffixIcon: const Icon(Icons.numbers),
                  controller: _clientNumberController,
                  isNumbersOnly: true,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: clientType,
                  builder: (context, category, child) {
                    return CategorySelectionField(
                      categories: const ['تاجر', 'مصنع', 'مورد'],
                      isSearchable: false,
                      isEditable: false,
                      selectedCategory: category,
                      onCategorySelected: (category) {
                        clientType.value = category;
                      },
                      onNewCategoryAdded: (newCategory) {},
                    );
                  },
                ),
              ],
            ),
          ),
          MakeOrderDetailsForm(
            qtyController: _qtyController,
            priceController: _priceController,
            productModel: orderCubit.productModel,
            barcodes: barcodes,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ElevatedButton(
              onPressed: () {
                if (int.parse(_qtyController.text) >=
                    BlocProvider.of<MakeOrderCubit>(context).productModel.qty) {
                  ShowInfoUtil.showSnackBar(
                      context, "الكمية المطلوبة اكبر من الكمية المتاحة");
                  return;
                }
                if (_qtyController.text.isNotEmpty &&
                    barcodes.length != double.parse(_qtyController.text)) {
                  ShowInfoUtil.showSnackBar(context,
                      "يجب ادخال الباركود الخاص بجميع الوحدات\n عدد الوحدات لا يساوي عدد الباركود");
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  orderCubit.makeOrder(
                    OrderModel(
                      product: orderCubit.productModel,
                      serialNumbers: barcodes,
                      price: double.parse(_priceController.text),
                      quantity: int.parse(_qtyController.text),
                      clientName: _clientNameController.text,
                      clientPhoneNumber: _clientNumberController.text,
                      clientType: clientType.value,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              ),
              child: const Text(
                "تسليم",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
