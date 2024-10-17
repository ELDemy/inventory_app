import 'package:flutter/material.dart';

import 'features/barcode/flutter_barcode_scanner.dart';

void main() {
  runApp(const InventoryApp());
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestBarcode(),
    );
  }
}
