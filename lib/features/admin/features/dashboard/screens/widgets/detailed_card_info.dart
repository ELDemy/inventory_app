import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';

class DetailedInfoCard extends StatelessWidget {
  const DetailedInfoCard({
    super.key,
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.primaryColor,
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: child,
        ),
      ),
    );
  }
}
