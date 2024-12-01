import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({
    super.key,
    required this.title,
    required this.data1,
    required this.data2,
    required this.onCardTap,
    required this.childBuilder,
    required this.itemCount,
  });

  final String title;
  final String data1;
  final String data2;
  final Widget Function(int index) childBuilder;
  final Function(int index) onCardTap;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تقارير العمل')),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemCount + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _topWidget(context);

                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      splashColor: AppColors.primaryColor,
                      onTap: () => onCardTap(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10),
                        child: childBuilder(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomResponsiveRow(
        children: [
          Text(title, style: AppTextStyles.headLine24),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(data1, style: AppTextStyles.textStyle18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(data2, style: AppTextStyles.textStyle18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
