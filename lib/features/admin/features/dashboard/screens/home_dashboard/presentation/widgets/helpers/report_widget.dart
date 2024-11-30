import 'package:flutter/material.dart';

import 'show_all_arrow.dart';
import 'title_row.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.title,
    required this.showAllOnTap,
    required this.childBuilder,
    this.height = 140,
    this.itemCount = 6,
  });

  final String title;
  final VoidCallback showAllOnTap;
  final double height;
  final int itemCount;
  final Widget Function(int index) childBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleRow(title: title, showAllOnTap: showAllOnTap),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == itemCount - 1) {
                return ShowAllArrow(onTap: showAllOnTap);
              }
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 160),
                child: Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: childBuilder(index),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
