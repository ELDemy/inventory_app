// lib/di/injector.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/di/auth_service.dart';
import 'package:inventory_app/features/product_management/shared/data/product_management_repo/product_management_repo.dart';
import 'package:inventory_app/features/user_management/data/user_model.dart';

class Injector {
  static bool isOnline = true; // checker if the user is online or not

  static final GetIt _getIt = GetIt.instance;
  static UserModel? userModel;

  // Initialize all the dependencies
  static void init() async {
    _getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
    _getIt.registerSingleton<ProductManagementRepo>(ProductManagementRepo());
    _getIt.registerSingleton<AuthService>(AuthService());
  }

  // fireStore database
  static final DocumentReference<Map<String, dynamic>> projectDoc =
      _getIt.get<FirebaseFirestore>().doc('projects/inverters');

  static final CollectionReference<Map<String, dynamic>> productsCollection =
      projectDoc.collection('products');

  static final DocumentReference<Map<String, dynamic>> allProductsDoc =
      productsCollection.doc('all');

  static final CollectionReference<Map<String, dynamic>>
      productsHistoryCollection = projectDoc.collection('products_history');

  static final CollectionReference<Map<String, dynamic>> usersCollection =
      projectDoc.collection('users');

  static DocumentReference<Map<String, dynamic>>? userDoc;
  static Map<String, dynamic>? userData;
  // Generic method to get instances
  static T get<T extends Object>() => _getIt<T>();
}
