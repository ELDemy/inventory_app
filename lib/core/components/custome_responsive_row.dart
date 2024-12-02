import 'package:flutter/material.dart';

class CustomResponsiveRow extends StatelessWidget {
  const CustomResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisSize,
  });

  final List<Widget> children;
  final MainAxisSize? mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: children,
          ),
        ),
      ],
    );
  }
}
