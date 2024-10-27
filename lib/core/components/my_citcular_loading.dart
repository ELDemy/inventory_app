import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class MyCircularLoading extends StatelessWidget {
  const MyCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    );
  }
}
