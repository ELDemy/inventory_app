import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TopInfoCard extends StatelessWidget {
  const TopInfoCard({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(content, style: AppTextStyles.textStyle18),
        ),
      ),
    );
  }
}
