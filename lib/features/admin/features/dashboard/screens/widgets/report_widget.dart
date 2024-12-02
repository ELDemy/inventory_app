import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

import 'show_all_arrow.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.title,
    required this.showAllOnTap,
    required this.childBuilder,
    required this.onCardTap,
    this.height = 140,
    this.itemCount = 6,
  });

  final String title;
  final VoidCallback showAllOnTap;
  final double height;
  final int itemCount;
  final Widget Function(int index) childBuilder;
  final Function(int index) onCardTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          _titleRow(),
          itemCount > 0
              ? _cardsListView()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "لا يوجد بيانات",
                    style: AppTextStyles.textStyle16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _titleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.headLine24),
          if (itemCount > 4)
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
      ),
    );
  }

  SizedBox _cardsListView() {
    return SizedBox(
      height: height,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount <= 5 ? itemCount : 6,
        itemBuilder: (context, index) {
          if (index == 5) return ShowAllArrow(onTap: showAllOnTap);

          return ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 160),
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: AppColors.primaryColor,
                onTap: () {
                  onCardTap(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: childBuilder(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
