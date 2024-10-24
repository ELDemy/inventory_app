import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.suffixIcon,
    this.isRequired = false,
    this.isNumbersOnly = false,
  });

  final bool isRequired;
  final String labelText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool isNumbersOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        validator: _validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: isNumbersOnly ? TextInputType.number : null,
        inputFormatters: [
          if (isNumbersOnly) FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          label: _label(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  String? _validator(data) {
    if (isRequired && data!.isEmpty) {
      return "هذا البيان مطلوب";
    }
    return null;
  }

  Text _label() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: labelText),
          if (isRequired)
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
