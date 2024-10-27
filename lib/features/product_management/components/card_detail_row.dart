import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class CardDetailRow extends StatelessWidget {
  const CardDetailRow({
    super.key,
    required this.label,
    required this.content,
    this.iconWidget,
    this.iconData,
  });

  final String label;
  final String content;
  final Widget? iconWidget;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget ?? Icon(iconData, size: 20),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                    color: AppColors.primaryColor, fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
