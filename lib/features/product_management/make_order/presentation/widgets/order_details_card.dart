import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custom_text_form_field.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/app_icons.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';

import 'custom_card.dart';

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
                    child: _addBarcode(),
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

  InkWell _addBarcode() {
    return InkWell(
      onTap: () async {
        String barcode = await BarcodeUtil.scanBarcodeNormal();
        if (widget.barcodes.contains(barcode)) {
          ShowInfoUtil.showSnackBar(context, "تم اضافته بالفعل");
          return;
        }
        widget.barcodes.add(barcode);
        setState(() {});
      },
      child: AppIcons.barcodeIcon(
        height: 40,
        color: AppColors.primaryColor,
      ),
    );
  }

  double get getPrice {
    return widget.qtyController.text.isNotEmpty
        ? widget.productModel.price * double.parse(widget.qtyController.text)
        : 0;
  }
}
