// lib/di/injector.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';

class Injector {
  static bool isOnline = true; // checker if the user is online or not

  static final GetIt _getIt = GetIt.instance;

  // Initialize all the dependencies
  static void init() {
    _getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
    _getIt.registerSingleton<ProductManagementRepo>(ProductManagementRepo());
  }

  static final DocumentReference<Map<String, dynamic>> projectDoc =
      _getIt.get<FirebaseFirestore>().doc('projects/inverters');

  static final CollectionReference<Map<String, dynamic>> productsCollection =
      projectDoc.collection('products');

  static final CollectionReference<Map<String, dynamic>>
      productsHistoryCollection = projectDoc.collection('products_history');

  static final DocumentReference<Map<String, dynamic>> allProductsDoc =
      productsCollection.doc('all');

  // Generic method to get instances
  static T get<T extends Object>() => _getIt<T>();
}
