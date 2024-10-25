import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/data/service/service_state.dart';

class MyFirebaseService {
  final DocumentReference<Map<String, dynamic>> projectDoc =
      FirebaseFirestore.instance.doc('projects/inverters');

  void get() async {
    try {
      var x = await projectDoc
          .collection("products/A1/customer_orders")
          .where("sn_list", arrayContains: "123")
          .get();

      print("Successfully completed");
      for (var docSnapshot in x.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    } on FirebaseException catch (e) {
      print('Error fetching documents: ${e.message}');
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  Future<ServiceState?> addNewModel(ProductModel productModel) async {
    log("ELDemy:: invoked $addNewModel");
    try {
      final docRef =
          projectDoc.collection('products').doc(productModel.identifierSN);

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        print('Document with ID ${productModel.identifierSN} already exists.');
        return ServiceState(
            serviceStateMsg:
                "المنتج رقم ${productModel.identifierSN} موجود بالفعل ");
      } else {
        await docRef.set(productModel.toFirestore());
        print(
            'Document with ID ${productModel.identifierSN} has been created.');
      }
    } on FirebaseException catch (firebaseException) {
      print('Error creating document: ${firebaseException.message}');
      return ServiceState.firebaseException(firebaseException);
    } catch (e) {
      print('An unexpected error occurred: $e');
      return ServiceState(
          serviceStateMsg: "حدث خطأ غير متوقع برجاء المحاوله مره اخري!!");
    }
    return null;
  }
}
