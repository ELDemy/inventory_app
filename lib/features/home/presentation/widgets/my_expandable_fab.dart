import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:inventory_app/core/components/my_barcode_icon.dart';
import 'package:inventory_app/core/utils/app_colors.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/features/product_management/add_edit_product/presentation/add_new_product/add_new_product_screen.dart';
import 'package:inventory_app/features/product_management/find_order/presentation/find_order_screen.dart';
import 'package:inventory_app/features/product_management/make_order/presentation/make_order_screen.dart';

class MyExpandableFAB extends StatefulWidget {
  const MyExpandableFAB({
    super.key,
  });

  @override
  State<MyExpandableFAB> createState() => _MyExpandableFABState();
}

class _MyExpandableFABState extends State<MyExpandableFAB> {
  final GlobalKey<ExpandableFabState> _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
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
        _addNewProductButton(),
      ],
    );
  }

  FloatingActionButton _scanBarcodeButton() {
    return FloatingActionButton(
      heroTag: "scanBarcode",
      backgroundColor: AppColors.fabBackgroundColor,
      foregroundColor: AppColors.fabIconsColor,
      child: const MyBarcodeIcon(color: AppColors.fabIconsColor),
      onPressed: () async {
        _key.currentState?.toggle();
        String barcodeScanRes = await BarcodeUtil.scanBarcodeNormal();
        if (barcodeScanRes == "-1") {
          return; // to not push if the code is invalid
        }

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindOrderScreen(barcode: barcodeScanRes)),
        );
      },
    );
  }

  FloatingActionButton _orderButton() {
    return FloatingActionButton(
      heroTag: "order",
      backgroundColor: AppColors.fabBackgroundColor,
      foregroundColor: AppColors.fabIconsColor,
      child: const Icon(Icons.shopping_cart_outlined),
      onPressed: () async {
        _key.currentState?.toggle();

        String barcodeScanRes = await BarcodeUtil.scanBarcodeNormal();
        if (barcodeScanRes == "-1") {
          return; // to not push if the code is invalid
        }

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MakeOrderScreen(barcode: barcodeScanRes)),
        );
      },
    );
  }

  FloatingActionButton _addNewProductButton() {
    return FloatingActionButton(
      heroTag: "add order",
      backgroundColor: AppColors.fabBackgroundColor,
      foregroundColor: AppColors.fabIconsColor,
      child: const Icon(
        Icons.add_circle_outline_rounded,
        size: 26,
      ),
      onPressed: () async {
        _key.currentState?.toggle();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddNewProductScreen()),
        );
      },
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
      child: const MyBarcodeIcon(color: AppColors.fabIconsColor),
      backgroundColor: AppColors.fabBackgroundColor,
    );
  }
}
