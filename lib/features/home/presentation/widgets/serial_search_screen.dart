import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custom_serial_text_form_field.dart';

class SerialSearchScreen extends StatefulWidget {
  const SerialSearchScreen(this.onSubmit, {super.key});
  final void Function(String barcode) onSubmit;

  @override
  State<SerialSearchScreen> createState() => _SerialSearchScreenState();
}

class _SerialSearchScreenState extends State<SerialSearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ادخل الرقم التسلسلي للمنتج")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset("assets/logo.png", height: 200),
            CustomSerialTextFormField(controller: controller),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.isEmpty ||
                            controller.text == "-1") {
                          return;
                        }
                        widget.onSubmit(controller.text);
                      },
                      child: const Text("بحث", style: TextStyle(fontSize: 20))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
