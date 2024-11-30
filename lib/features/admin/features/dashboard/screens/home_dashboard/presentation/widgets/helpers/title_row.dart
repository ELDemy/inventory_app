import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
    required this.title,
    required this.showAllOnTap,
  });

  final String title;
  final VoidCallback showAllOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headLine24),
        InkWell(
          onTap: showAllOnTap,
          borderRadius: BorderRadius.circular(50),
          child: Text(
            "عرض الكل",
            style: AppTextStyles.textStyle16.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        )
      ],
    );
  }
}
