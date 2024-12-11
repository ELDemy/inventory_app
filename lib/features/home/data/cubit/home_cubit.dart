import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/power_utils.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/auth_service.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/home/data/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _allProducts = [];
    _homeRepo = Injector.register<HomeRepo>(HomeRepo());
  } // ChangeNotifierProvider(create: (context) => HomeCubit()),

  late HomeRepo _homeRepo;
  late List<ProductModel> _allProducts;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  List<ProductModel> get activeProducts {
    if (selectedCategory == null) return _allProducts;
    return _allProducts
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  List<ProductModel>? searchedProducts;
  String? selectedCategory;

  getProductModelsStream(BuildContext context) async {
    emit(HomeLoading());
    try {
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
        (List<ConnectivityResult> result) {
          result.contains(ConnectivityResult.none)
              ? Injector.isOnline = false
              : Injector.isOnline = true;
          // emit(InternetState());
        },
      );
      await _getCategories();
      _subscription = _homeRepo.getProductsStream().listen(
        (snapshot) {
          final Map<String, dynamic>? data = snapshot.data();
          if (data != null) {
            _allProducts = PowerUtils.sortProductsByPower(_parseProducts(data));
            activeProducts; // to update the products list
            emit(HomeProductsState());
          }
        },
        onError: (error) {
          FirebaseAnalytics.instance.logEvent(
            name: "error_in_products_listener",
            parameters: {"error": error.toString()},
          );
          if (error.toString().toLowerCase().contains('permission-denied')) {
            Injector.get<AuthService>().handleUserDeletion(context);
          }
        },
      );
    } on FirebaseException catch (e) {
      return emit(HomeFailure(FirebaseFailure.fromFirebaseException(e).errMsg));
    } catch (e) {
      Failure.exception(e);
      return emit(HomeFailure("حدث خطأ!!"));
    }
  }

  Future<void> _getCategories() async {
    DocumentSnapshot<Map<String, dynamic>> categories =
        await _homeRepo.getProductsCategories();
    if (categories.data() != null) {
      Injector.productsCategories = categories.data()!.keys.toList()
        ..sort((a, b) => a.compareTo(b));
    }
    return;
  }

  List<ProductModel> _parseProducts(Map<String, dynamic> data) {
    List<ProductModel> allProducts = [];
    for (var key in data.keys) {
      allProducts
          .add(ProductModel.fromFirestore(data[key], null, identifierSN: key));
    }
    return allProducts;
  }

  void setSearchedProducts(String searchText) {
    searchText = searchText.toLowerCase();
    searchedProducts = activeProducts.where((product) {
      final bool isIdentifierMatches = product.identifierSN != null &&
          product.identifierSN!.toLowerCase().contains(searchText);

      final bool isNameMatches = product.productName != null &&
          product.productName!.toLowerCase().contains(searchText);

      return isIdentifierMatches || isNameMatches;
    }).toList();

    emit(HomeSearchedProducts(searchedProducts));
  }

  void clearSearchedProducts() {
    searchedProducts = null;
    emit(HomeProductsState());
  }

  void changeCategory(String? category) {
    selectedCategory = category;
    activeProducts;
    emit(HomeProductsState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _connectivitySubscription?.cancel();
    Injector.unregister<HomeCubit>();
    return super.close();
  }
}

// update the products list in all products doc
//  oneTimeUpdate() async {
//     var data = await Injector.productsCollection.get();
//     var products = data.docs.map((doc) {
//       if (doc.id == "all") {
//         return null;
//       }
//       return ProductModel.fromFirestore(doc.data(), null, identifierSN: doc.id);
//     }).toList();
//     for (var product in products) {
//       if (product == null) continue;
//       await Injector.allProductsDoc.update(product.toFirestoreBasicValues());
//     }
//   }
