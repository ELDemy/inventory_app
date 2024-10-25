// lib/di/injector.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static final GetIt _getIt = GetIt.instance;

  // Initialize all the dependencies
  static void init() {
    _getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  }

  static final DocumentReference<Map<String, dynamic>> projectDoc =
      Injector.get<FirebaseFirestore>().doc('projects/inverters');

  static final DocumentReference<Map<String, dynamic>> allProductsDoc =
      Injector.get<FirebaseFirestore>().doc('projects/inverters/products/all');
  // Generic method to get instances
  static T get<T extends Object>() => _getIt<T>();
}
