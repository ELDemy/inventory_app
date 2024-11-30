import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFFDCA500);
  static const Color primaryBackgroundColor = Color(0xFFF5FCFB);
  static const Color cardBackgroundColor = Color(0xFFF5FCFB);

  static const Color foregroundColor = Colors.black;
  static const Color labelColor = Color(0xFFCC9900);
  static const Color greyColor = Color(0xff999999);

  static const Color iconsColor = Colors.black;
  static const Color appBarIconsColor = Colors.black;

  static const Color fabIconsColor = Colors.black;
  static const Color fabBackgroundColor = primaryColor;

  static const Color categoriesWidgetBackgroundColor = Color(0xFFFFFAF0);

  static const Color lightRedColor = Color(0xFFD45353);
  static const Color lightGreenColor = Color(0xFF53D48C);
  static const Color lightPrimaryColor = Color(0xFFDCA500);

  /*
  Primary Color (for header/main elements):
  A warm but professional golden yellow: #F2B705
  Or a slightly muted yellow: #FFD700

  Secondary/Accent Colors:
  Lighter yellow for backgrounds: #FFF5D6
  Darker yellow for text/icons: #CC9900
  White (#FFFFFF) for contrast elements

  For the floating action button currently in blue, I'd suggest using #F2B705 with a slightly darker shade #CC9900 for the hover state.

  #FFFDF5 (Very subtle warm white with barely noticeable yellow tint)
  #FFFAF0 (Floral white - extremely light with just a touch of warmth)
  #FFFCEB (Light cream - slightly warmer but still very close to white)
   */
  // static const Color lightPendingColor = Color(0xFFF5FCFB);
  // static const Color lightApprovedColor = Color(0xFFFAFDF5);
  // static const Color approvedColor = Color(0xFFA3D139);
  // static const Color lightRejectedColor = Color(0xFFFFF9F8);
  // static const Color rejectedColor = Color(0xFFFF6556);
  //
  // static Color lightBlack = Colors.black.withOpacity(.6);
}
