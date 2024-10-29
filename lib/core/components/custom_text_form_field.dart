import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.suffixIcon,
    this.isRequired = false,
    this.isNumbersOnly = false,
    this.onChanged,
  });

  final bool isRequired;
  final String labelText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool isNumbersOnly;
  final Function(String value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: _validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: isNumbersOnly ? TextInputType.number : null,
        inputFormatters: [
          if (isNumbersOnly)
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          label: _label(),
          labelStyle: TextStyle(color: AppColors.labelColor),
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
            const TextSpan(text: " *", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
