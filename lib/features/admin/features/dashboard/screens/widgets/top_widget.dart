import 'package:flutter/material.dart';
import 'package:inventory_app/core/components/custome_responsive_row.dart';
import 'package:inventory_app/core/utils/app_themes/app_text_styles.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.title, required this.children});

  final String title;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return _listview();
  }

  Widget _listview() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return _topInfoCard(children[index]);
        },
      ),
    );
  }

  CustomResponsiveRow _old() {
    return CustomResponsiveRow(
      children: [
        // Text(title, style: AppTextStyles.headLine24),
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: children.map((data) => _topInfoCard(data)).toList(),
        ),
      ],
    );
  }

  Widget _topInfoCard(String data) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(data, style: AppTextStyles.textStyle18),
      ),
    );
  }
}

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
