import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.title, required this.child, this.iconData});

  final Widget child;
  final String title;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 5,
        color: AppColors.primaryBackgroundColor,
        // surfaceTintColor: AppColors.primaryColor.withOpacity(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Column(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(iconData ?? Icons.info_outline_rounded, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Divider(color: AppColors.primaryColor, thickness: 1),
              Row(
                children: [
                  Expanded(child: child),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
