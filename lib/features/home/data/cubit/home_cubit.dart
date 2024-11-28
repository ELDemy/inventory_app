import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/di/auth_service.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/home/data/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepo homeRepo = HomeRepo();
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  List<ProductModel> _allProducts = [];

  List<ProductModel> get products {
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
          emit(InternetState());
        },
      );
      await _getCategories();
      _subscription = homeRepo.getProductsStream().listen(
        (snapshot) {
          final Map<String, dynamic>? data = snapshot.data();
          if (data != null) {
            _allProducts = _parseProducts(data);
            products;
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
        await homeRepo.getProductsCategories();
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
    searchedProducts = products.where((product) {
      final identifierMatches = product.identifierSN != null &&
          product.identifierSN!.toLowerCase().contains(searchText);

      final nameMatches = product.productName != null &&
          product.productName!.toLowerCase().contains(searchText);

      return identifierMatches || nameMatches;
    }).toList();

    emit(HomeSearchedProducts(searchedProducts));
  }

  void clearSearchedProducts() {
    searchedProducts = null;
    emit(HomeProductsState());
  }

  void changeCategory(String? category) {
    selectedCategory = category;
    products;
    emit(HomeProductsState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
