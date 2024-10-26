import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/utils/app_colors.dart';

class MyExpandableFAB extends StatelessWidget {
  const MyExpandableFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      duration: const Duration(milliseconds: 350),
      pos: ExpandableFabPos.left,
      type: ExpandableFabType.up,
      distance: 80.0,
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      openButtonBuilder: _openButtonBuilder(),
      closeButtonBuilder: _closedButtonBuilder(),
      children: [
        _scanBarcodeButton(),
        _orderButton(),
      ],
    );
  }

  FloatingActionButton _orderButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.foregroundColor,
      child: const Icon(Icons.shopping_cart_outlined),
      onPressed: () {},
    );
  }

  FloatingActionButton _scanBarcodeButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.foregroundColor,
      child: SvgPicture.asset(
        height: 35,
        "assets/icons/barcode-icon.svg",
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      onPressed: () {},
    );
  }

  FloatingActionButtonBuilder _closedButtonBuilder() {
    return FloatingActionButtonBuilder(
      size: 90,
      builder: (BuildContext context, void Function()? onPressed,
          Animation<double> progress) {
        return IconButton(
            padding: const EdgeInsets.all(20),
            onPressed: onPressed,
            icon: const Icon(Icons.close_rounded));
      },
    );
  }

  RotateFloatingActionButtonBuilder _openButtonBuilder() {
    return RotateFloatingActionButtonBuilder(
      child: SvgPicture.asset(
        height: 35,
        "assets/icons/barcode-icon.svg",
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
