import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  SvgPicture barcodeIcon({double? height, Color color = Colors.white}) {
    return SvgPicture.asset(
      height: height,
      "assets/icons/barcode-icon.svg",
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  Image appLogo({double height = 200}) {
    return Image.asset("assets/logo.png", height: height);
  }
}
