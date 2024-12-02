import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/utils/app_themes/app_colors.dart';

class MyBarcodeIcon extends StatelessWidget {
  const MyBarcodeIcon({
    super.key,
    this.height = 35,
    this.color = AppColors.iconsColor,
  });
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      height: height,
      "assets/icons/barcode-icon.svg",
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
