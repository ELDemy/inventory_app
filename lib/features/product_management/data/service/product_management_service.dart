import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/service/service_state.dart';

class ProductManagementService {
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
        Injector.get<FirebaseFirestore>().runTransaction(
          (transaction) async {
            transaction.set(docRef, productModel.toFirestore());
            transaction.update(
              Injector.allProductsDoc,
              productModel.toFirestoreBasicValues(),
            );
          },
        ).then((value) {
          print(
              'Document with ID ${productModel.identifierSN} has been created.');
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
}
