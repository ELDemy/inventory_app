import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';

class ProductManagementRepo {
  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      String identifierSN) async {
    try {
      return await Injector.productsCollection.doc(identifierSN).get();
    } on Exception catch (e) {
      log("Error getting Product $identifierSN  : ${e.toString()}");
      rethrow;
    }
  }

  Future<void> deleteProduct(String identifierSN) async {
    try {
      FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.delete(Injector.productsCollection.doc(identifierSN));
          transaction.update(
              Injector.allProductsDoc, {identifierSN: FieldValue.delete()});
        },
      );
      return await Injector.productsCollection.doc(identifierSN).delete();
    } on Exception catch (e) {
      log("Error getting Product $identifierSN  : ${e.toString()}");
      rethrow;
    }
  }

  Future<void> addProduct(ProductModel productModel) async {
    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          Injector.productsCollection.doc(productModel.identifierSN);
      final DocumentReference<Map<String, dynamic>> allProductsDocRef =
          Injector.allProductsDoc;

      return await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.set(docRef, productModel.toFirestore());
          transaction.set(
            allProductsDocRef,
            productModel.toFirestoreBasicValues(),
            SetOptions(merge: true),
          );
        },
      );
    } on FirebaseException catch (firebaseException) {
      print('Error creating document: ${firebaseException.message}');
      rethrow;
    } catch (e) {
      print('An unexpected error occurred: $e');
      rethrow;
    }
  }

  Future<void> makeOrder(OrderModel orderModel) async {
    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          Injector.productsHistoryCollection.doc();

      return await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.set(docRef, orderModel.toFirestore());
          transaction.update(
            Injector.allProductsDoc,
            {
              '${orderModel.product.identifierSN}.quantity':
                  FieldValue.increment(-orderModel.quantity),
            },
          );
          transaction.update(
            Injector.productsCollection.doc(orderModel.product.identifierSN),
            {'quantity': FieldValue.increment(-orderModel.quantity)},
          );
        },
      );
    } on FirebaseException catch (firebaseException) {
      print('Error creating document: ${firebaseException.message}');
      rethrow;
    } catch (e) {
      print('An unexpected error occurred: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrder(String barcode) async {
    try {
      QuerySnapshot<Map<String, dynamic>> x = await Injector
          .productsHistoryCollection
          .where("serialNumbers", arrayContains: barcode)
          .limit(1)
          .get();
      return x;
    } on Exception catch (e) {
      log("Error getting Product $barcode  : ${e.toString()}");
      rethrow;
    }
  }
}
