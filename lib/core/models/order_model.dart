import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';

class OrderModel {
  final ProductModel product;
  final List<String> serialNumbers;
  final String? employee;
  final int quantity;
  final double price;
  final String? clientName;
  final String? clientPhoneNumber;
  final DateTime? creationTime;

  OrderModel({
    required this.product,
    required this.serialNumbers,
    this.employee,
    this.clientName,
    this.clientPhoneNumber,
    required this.quantity,
    required this.price,
    this.creationTime,
  });

  // Factory constructor to create OrderModel from Firestore
  factory OrderModel.fromFirestore(
    Map<String, dynamic>? data,
    SnapshotOptions? options,
  ) {
    return OrderModel(
      product: ProductModel.fromFirestore(data?['product'], null),
      serialNumbers: data?['serialNumbers'] is Iterable
          ? List<String>.from(data?['serialNumbers'])
          : [],
      employee: data?['employee'],
      clientName: data?['clientName'],
      clientPhoneNumber: data?['clientPhoneNumber'],
      price: data?['price'] ?? 0,
      quantity: data?['quantity'] ?? 0,
      creationTime: data?['creationTime'] is Timestamp
          ? (data?['creationTime'] as Timestamp).toDate()
          : data?['creationTime'] as DateTime?,
    );
  }

  // Convert OrderModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      "creationTime": DateTime.now(),
      "employee": Injector.userModel?.name ?? "",
      "product": product.toFirestore(),
      "serialNumbers": serialNumbers,
      "price": price,
      "quantity": quantity,
      "clientName": clientName,
      "clientPhoneNumber": clientPhoneNumber,
    };
  }
}
