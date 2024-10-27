import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/product_model.dart';

class OrderModel {
  final ProductModel product;
  final List<String> serialNumbers;
  final String employee;
  final int quantity;
  final double orderPrice;
  final String? clientName;
  final String? clientPhoneNumber;
  final DateTime? creationTime;

  OrderModel({
    required this.product,
    required this.serialNumbers,
    String? employee,
    this.clientName,
    this.clientPhoneNumber,
    required this.quantity,
    required this.orderPrice,
    DateTime? creationTime,
  })  : this.creationTime = creationTime ?? DateTime.now(),
        this.employee = employee ?? "employeeName";

  // Factory constructor to create OrderModel from Firestore
  factory OrderModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderModel(
      product: ProductModel.fromFirestore(data?['product'], null),
      serialNumbers: data?['serialNumbers'] is Iterable
          ? List<String>.from(data?['serialNumbers'])
          : [],
      employee: data?['employee'] ?? '',
      clientName: data?['clientName'],
      clientPhoneNumber: data?['clientPhoneNumber'],
      orderPrice: data?['priceSale'] ?? 0,
      quantity: data?['quantity'] ?? 0,
      creationTime: data?['creationTime'],
    );
  }

  // Convert OrderModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      "product": product.toFirestore(), // Assuming product has this method
      "serialNumbers": serialNumbers,
      "employee": employee,
      "priceSale": orderPrice,
      "quantity": quantity,
      "creationTime": creationTime,
      if (clientName != null) "clientName": clientName,
      if (clientPhoneNumber != null) "clientPhoneNumber": clientPhoneNumber,
    };
  }
}
