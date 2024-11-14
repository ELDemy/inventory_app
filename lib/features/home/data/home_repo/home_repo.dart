import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/di/injector.dart';

class HomeRepo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductsStream() {
    try {
      return Injector.allProductsDoc.snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductsCategories() async {
    try {
      return await Injector.productsCategoriesDoc.get();
    } on Exception catch (e) {
      rethrow;
    }
  }
}
