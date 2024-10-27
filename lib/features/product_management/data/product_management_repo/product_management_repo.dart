import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/service_state.dart';

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

  Future<ServiceState?> addNewProductModel(ProductModel productModel) async {
    ServiceState? serviceState;
    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          Injector.productsCollection.doc(productModel.identifierSN);

      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await docRef.get();

      if (docSnapshot.exists) {
        print('Document with ID ${productModel.identifierSN} already exists.');
        return ServiceState(
            serviceStateMsg:
                "المنتج رقم ${productModel.identifierSN} موجود بالفعل ");
      } else {
        await Injector.get<FirebaseFirestore>().runTransaction(
          (transaction) async {
            transaction.set(docRef, productModel.toFirestore());
            transaction.update(
              Injector.allProductsDoc,
              productModel.toFirestoreBasicValues(),
            );
          },
        ).then((value) {
          print('Order Transaction has been created successfully.');
          return null;
        }).onError((error, stackTrace) {
          print("Error: $error");
          serviceState =
              ServiceState(serviceStateMsg: "برجاء المحاول مره اخرى");
        });
      }
    } on FirebaseException catch (firebaseException) {
      print('Error creating document: ${firebaseException.message}');
      return ServiceState.firebaseException(firebaseException);
    } catch (e) {
      print('An unexpected error occurred: $e');
      return ServiceState(
          serviceStateMsg: "حدث خطأ غير متوقع برجاء المحاوله مره اخري!!");
    }
    return serviceState;
  }

  Future<void> makeOrder(OrderModel orderModel) async {
    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          Injector.productsHistoryCollection.doc();

      return await Injector.get<FirebaseFirestore>().runTransaction(
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
}
