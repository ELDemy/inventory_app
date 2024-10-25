import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? identifierSN;
  String? serialNumber;
  final String? productName;
  final num? power;
  final String? input;
  final String? output;
  final double? price;

  ProductModel({
    this.serialNumber,
    this.identifierSN,
    required this.productName,
    this.power,
    this.input,
    this.output,
    this.price,
  }) {
    parseIdentifierSN();
  }

  parseIdentifierSN() {
    if (serialNumber != null && identifierSN == null) {
      if (serialNumber!.length >= 20) {
        identifierSN = serialNumber!.substring(0, 10);
      } else if (serialNumber!.length >= 6) {
        identifierSN = serialNumber!.substring(0, 6);
      } else {
        log("unrecognized");
        identifierSN = serialNumber;
      }
    }
  }

  // Factory constructor to create ProductModel from Firestore
  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      identifierSN: data?['identifierSN'],
      serialNumber: data?['serialNumber'],
      productName: data?['modelName'],
      power: data?['power'] != null ? (data?['power'] as num) : null,
      input: data?['input'],
      output: data?['output'],
      price: data?['price'] != null ? (data?['price'] as double) : null,
    );
  }

  // Convert ProductModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      "identifierSN": identifierSN,
      "serialNumber": serialNumber,
      "modelName": productName,
      if (power != null) "power": power,
      if (input != null) "input": input,
      if (output != null) "output": output,
      if (price != null) "price": price,
    };
  }
}
