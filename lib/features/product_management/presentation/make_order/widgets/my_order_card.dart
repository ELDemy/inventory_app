import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 5,
        color: AppColors.primaryBackgroundColor,
        // surfaceTintColor: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              const Divider(color: AppColors.primaryColor, thickness: 1),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
