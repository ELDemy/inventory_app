// order_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/di/injector.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrdersByDateRange(
      {required DateTime startDate, required DateTime endDate});
}

class FirebaseOrderRepository implements OrderRepository {
  @override
  Future<List<OrderModel>> getOrdersByDateRange(
      {required DateTime startDate, required DateTime endDate}) async {
    QuerySnapshot querySnapshot = await Injector.ordersHistoryCollection
        .where('creationTime', isGreaterThanOrEqualTo: startDate)
        .where('creationTime', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs
        .map((doc) => OrderModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
