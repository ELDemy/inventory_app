import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';

class ReportDetailsCard extends StatelessWidget {
  const ReportDetailsCard(
      {super.key, required this.onCardTap, required this.child});

  final VoidCallback onCardTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.primaryColor,
        onTap: onCardTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: child,
        ),
      ),
    );
  }
}
