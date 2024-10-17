import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_app/features/barcode/data/barcode_data.dart';

class TestBarcode extends StatefulWidget {
  const TestBarcode({super.key});

  @override
  _TestBarcodeState createState() => _TestBarcodeState();
}

class _TestBarcodeState extends State<TestBarcode> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      rethrow;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> startBarcodeScanStream() async {
    BarcodeData().startBarcodeScanStream((barcode) {
      // setState(() {
      //   _scanBarcode = '$_scanBarcode\n$barcode';
      // });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes = await BarcodeData().scanBarcodeNormal();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode scan')),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => scanBarcodeNormal(),
                    child: const Text('Start barcode scan')),
                ElevatedButton(
                    onPressed: () => scanQR(),
                    child: const Text('Start QR scan')),
                ElevatedButton(
                    onPressed: () => startBarcodeScanStream(),
                    child: const Text('Start barcode scan stream')),
                Text('Scan result : $_scanBarcode\n',
                    style: const TextStyle(fontSize: 20))
              ],
            ),
          );
        },
      ),
    );
  }
}
