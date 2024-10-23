import 'package:flutter/material.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/features/product_functions/data/firebase_service.dart';

class TestProductFunctions extends StatefulWidget {
  const TestProductFunctions({super.key});

  @override
  State<TestProductFunctions> createState() => _TestProductFunctionsState();
}

class _TestProductFunctionsState extends State<TestProductFunctions> {
  String? _scanBarcode;
  Future<void> _scanBarcodeNormal() async {
    String barcodeScanRes = await BarcodeUtil.scanBarcodeNormal();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      print('ELDemy :: $mounted');
      return;
    }
    print('ELDemy :: $barcodeScanRes');
    await MyFirebaseService().addNewModel(barcodeScanRes);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    MyFirebaseService().get();
                  },
                  child: const Text('get '),
                ),
                ElevatedButton(
                  onPressed: () {
                    _scanBarcodeNormal();
                  },
                  child: const Text('add'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('stream'),
                ),
                Text('Scan result : $_scanBarcode ',
                    style: const TextStyle(fontSize: 20))
              ],
            ),
          );
        },
      ),
    );
  }
}
