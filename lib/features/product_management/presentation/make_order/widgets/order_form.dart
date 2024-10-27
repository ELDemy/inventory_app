import 'package:flutter/material.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/app_icons.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/features/product_management/presentation/components/custom_text_form_field.dart';
import 'package:inventory_app/features/product_management/presentation/make_order/widgets/custom_card.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key, required this.productModel});
  final ProductModel productModel;
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
            productModel: widget.productModel,
            barcodes: barcodes,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ElevatedButton(
              onPressed: () {
                if (_qtyController.text.isNotEmpty &&
                    barcodes.length != double.parse(_qtyController.text)) {
                  ShowInfoUtil.showSnackBar(
                    context,
                    "عدد الباركود لا يساوي الكميه المدخله",
                  );
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  var x = OrderModel(
                    product: widget.productModel,
                    serialNumbers: barcodes,
                    orderPrice: double.parse(_priceController.text),
                    quantity: int.parse(_qtyController.text),
                    clientName: _clientNameController.text,
                    clientPhoneNumber: _clientNameController.text,

                    ///todo:
                    employee: "employeeName",
                  ).toFirestore();
                  print(x);
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

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    super.key,
    required this.qtyController,
    required this.priceController,
    required this.productModel,
    required this.barcodes,
  });

  final TextEditingController qtyController;
  final TextEditingController priceController;
  final ProductModel productModel;
  final List<String> barcodes;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "تفاصيل الطلب",
      child: Column(
        children: [
          CustomTextFormField(
            labelText: "الكمية",
            suffixIcon: const Icon(Icons.local_grocery_store_outlined),
            controller: widget.qtyController,
            isNumbersOnly: true,
            isRequired: true,
            onChanged: (value) {
              setState(() {});
            },
          ),
          CustomTextFormField(
            labelText: "سعر البيع",
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$getPrice \$"),
              ],
            ),
            controller: widget.priceController,
            isNumbersOnly: true,
            isRequired: true,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        String barcode = await BarcodeUtil.scanBarcodeNormal();
                        widget.barcodes.add(barcode);
                        setState(() {});
                      },
                      child: AppIcons.barcodeIcon(
                        height: 40,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  ...widget.barcodes.map(
                    (barcode) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(barcode),
                        TextButton(
                          onPressed: () {
                            setState(() => widget.barcodes.remove(barcode));
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text("الغاء"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get getPrice {
    return widget.qtyController.text.isNotEmpty
        ? widget.productModel.price * double.parse(widget.qtyController.text)
        : 0;
  }
}
