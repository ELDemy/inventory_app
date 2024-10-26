import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/di/injector.dart';

class HomeRepo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductsStream() {
    try {
      // Return the stream of product snapshots
      return Injector.allProductsDoc.snapshots();
    } on FirebaseException catch (e) {
      print('Error fetching documents: ${e.message}');
      throw FirebaseFailure.fromFirebaseException(e);
    } catch (e) {
      print('An unexpected error occurred: $e');
      throw FirebaseFailure("حدث خطأ!!");
    }
  }
}
