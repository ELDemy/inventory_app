// lib/di/injector.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/core/models/user_model.dart';
import 'package:inventory_app/di/auth_service.dart';
import 'package:inventory_app/features/product_management/shared/data/product_management_repo/product_management_repo.dart';

class Injector {
  static bool isOnline = true; // checker if the user is online or not

  static final GetIt _getIt = GetIt.instance;
  static UserModel? activeUser; // the active user details

  // Initialize all the dependencies
  static void init() async {
    _getIt.registerSingleton<ProductManagementRepo>(ProductManagementRepo());
    _getIt.registerSingleton<AuthService>(AuthService());
  }

  static List<String> productsCategories = [];

  // fireStore database
  final projectDocName = 'inverters';

  static final DocumentReference<Map<String, dynamic>> projectDoc =
      FirebaseFirestore.instance.doc('projects/inverters');

  static final CollectionReference<Map<String, dynamic>> productsCollection =
      projectDoc.collection('products');

  static final DocumentReference<Map<String, dynamic>> allProductsDoc =
      productsCollection.doc('all');

  static final CollectionReference<Map<String, dynamic>>
      productsHistoryCollection = projectDoc.collection('products_history');

  static final CollectionReference<Map<String, dynamic>> usersCollection =
      projectDoc.collection('users');

  static DocumentReference<Map<String, dynamic>>? userDoc;

  static final CollectionReference<Map<String, dynamic>> constantsCollection =
      projectDoc.collection('constants');

  static final DocumentReference<Map<String, dynamic>> productsCategoriesDoc =
      constantsCollection.doc('categories');

  // Generic method to get instances
  static T get<T extends Object>() => _getIt<T>();
}
