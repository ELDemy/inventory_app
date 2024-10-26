import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/features/product_management/presentation/make_order/make_order_screen.dart';

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
        _orderButton(context),
      ],
    );
  }

  FloatingActionButton _orderButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "order",
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.foregroundColor,
      child: const Icon(Icons.shopping_cart_outlined),
      onPressed: () async {
        String barcodeScanRes = await BarcodeUtil.scanBarcodeNormal();
        // if (barcodeScanRes != -1) return; // to not push if the code is invalid
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MakeOrderScreen(barcode: barcodeScanRes)),
        );
      },
    );
  }

  FloatingActionButton _scanBarcodeButton() {
    return FloatingActionButton(
      heroTag: "scanBarcode",
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
      heroTag: "openButtonBuilder",
      child: SvgPicture.asset(
        height: 35,
        "assets/icons/barcode-icon.svg",
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
