import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/presentation/components/custom_text_form_field.dart';
import 'package:inventory_app/features/product_management/presentation/make_order/widgets/my_order_card.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _clientNumberController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyOrderCard(
          title: "بيانات العميل",
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
        MyOrderCard(
          title: "تفاصيل الطلب",
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "الكمية",
                suffixIcon: const Icon(Icons.local_grocery_store_outlined),
                controller: _qtyController,
                isNumbersOnly: true,
              ),
              CustomTextFormField(
                labelText: "سعر البيع",
                suffixIcon: const Text(""),
                controller: _priceController,
                isNumbersOnly: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
