import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'show_info_util.dart';

class BarcodeUtil {
  static Future<void> startBarcodeScanStream(
      Function(String barcode) onData) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    )?.listen(
      (barcode) {
        ShowInfoUtil.showToast(barcode);
        onData(barcode);
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  static Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      ShowInfoUtil.showToast(barcodeScanRes);
    } on PlatformException {
      log('Failed to get platform version.');
      barcodeScanRes = 'مشكله فالموبايل';
    }
    return barcodeScanRes;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    /// if (!mounted) return;
  }

// Future<void> scanQR() async {
//   String barcodeScanRes;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.QR);
//     print(barcodeScanRes);
//   } on PlatformException {
//     barcodeScanRes = 'Failed to get platform version.';
//   }
//
//   // If the widget was removed from the tree while the asynchronous platform
//   // message was in flight, we want to discard the reply rather than calling
//   // setState to update our non-existent appearance.
//   /// if (!mounted) return;
// }
}
