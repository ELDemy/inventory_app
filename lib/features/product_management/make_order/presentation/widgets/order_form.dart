import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/make_order/data/make_order_cubit/make_order_cubit.dart';

import 'custom_card.dart';
import 'order_details_card.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientNumberController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> barcodes = [];

  @override
  Widget build(BuildContext context) {
    MakeOrderCubit orderCubit = BlocProvider.of<MakeOrderCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomCard(
            title: "بيانات العميل",
            iconData: Icons.account_circle,
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
              ],
            ),
          ),
          OrderDetails(
            qtyController: _qtyController,
            priceController: _priceController,
            productModel: orderCubit.productModel,
            barcodes: barcodes,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ElevatedButton(
              onPressed: () {
                if (_qtyController.text.isNotEmpty &&
                    barcodes.length != double.parse(_qtyController.text)) {
                  ShowInfoUtil.showSnackBar(
                      context, "عدد الباركود لا يساوي الكميه المدخله");
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  orderCubit.makeOrder(
                    OrderModel(
                      product: orderCubit.productModel,
                      serialNumbers: barcodes,
                      orderPrice: double.parse(_priceController.text),
                      quantity: int.parse(_qtyController.text),
                      clientName: _clientNameController.text,
                      clientPhoneNumber: _clientNameController.text,

                      ///todo:
                      employee: "employeeName",
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
