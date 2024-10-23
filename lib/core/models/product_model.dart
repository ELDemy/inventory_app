import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String identifier;
  final String modelName;
  final num? power;
  final String? input;
  final String? output;
  final double? price;

  ProductModel({
    required this.identifier,
    required this.modelName,
    this.power,
    this.input,
    this.output,
    this.price,
  });

  // Factory constructor to create ProductModel from Firestore
  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      identifier: data?['serialNumber'],
      modelName: data?['modelName'],
      power: data?['power'] != null ? (data?['power'] as num) : null,
      input: data?['input'],
      output: data?['output'],
      price: data?['price'] != null ? (data?['price'] as double) : null,
    );
  }

  // Convert ProductModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      "serialNumber": identifier,
      "modelName": modelName,
      if (power != null) "power": power,
      if (input != null) "input": input,
      if (output != null) "output": output,
      if (price != null) "price": price,
    };
  }
}
