import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static SvgPicture barcodeIcon({double? height, Color color = Colors.white}) {
    return SvgPicture.asset(
      height: height,
      "assets/icons/barcode-icon.svg",
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
