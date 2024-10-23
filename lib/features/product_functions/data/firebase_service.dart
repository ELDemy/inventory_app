import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/models/product_model.dart';

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

  Future<void> addNewModel(String serialNumber) async {
    try {
      final docRef = projectDoc.collection('products').doc(serialNumber);

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        print('Document with ID $serialNumber already exists.');
      } else {
        await docRef.set(ProductModel(
          identifier: serialNumber,
          modelName: "A01",
          output: "10",
          input: "5",
          power: 20,
          price: 50,
        ).toFirestore());
        print('Document with ID $serialNumber has been created.');
      }
    } on FirebaseException catch (e) {
      print('Error creating document: ${e.message}');
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }
}
