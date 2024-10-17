import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'features/barcode/flutter_barcode_scanner.dart';

void main() {
  var db = FirebaseFirestore.instance;
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
