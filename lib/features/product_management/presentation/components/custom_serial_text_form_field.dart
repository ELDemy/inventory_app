import 'package:flutter/material.dart';
import 'package:inventory_app/features/product_management/data/utils/barcode_util.dart';

import 'custom_text_form_field.dart';

class CustomSerialTextFormField extends StatelessWidget {
  const CustomSerialTextFormField({super.key, required this.controller});
  final TextEditingController controller;

  Future<void> _scanBarcodeNormal() async {
    String barcodeScanRes = await BarcodeUtil.scanBarcodeNormal();
    controller.text = barcodeScanRes;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      labelText: "الرقم التسلسلي",
      controller: controller,
      isRequired: true,
      suffixIcon: IconButton(
        onPressed: () async {
          await _scanBarcodeNormal();
        },
        icon: const Icon(Icons.qr_code),
      ),
    );
  }
}
