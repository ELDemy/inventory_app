import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/auth/data/auth_service.dart';
import 'package:inventory_app/features/home/data/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(BuildContext context) : super(HomeInitial()) {
    getProductModelsStream(context);
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  List<ProductModel> products = [];
  List<ProductModel>? searchedProducts;

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

  @override
  Future<void> close() {
    _subscription?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }

  getProductModelsStream(BuildContext context) {
    emit(HomeLoading());
    try {
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
        (List<ConnectivityResult> result) {
          print("Internet Connectivity has changed: $result");
          result.contains(ConnectivityResult.none)
              ? Injector.isOnline = false
              : Injector.isOnline = true;

          emit(InternetState());
        },
      );
      _subscription = HomeRepo().getProductsStream().listen(
        (snapshot) {
          final Map<String, dynamic>? data = snapshot.data();
          if (data != null) {
            products = _parseProducts(data);
            emit(HomeProductsState());
          }
        },
        onError: (error) {
          print("Error in user document listener: $error");
          print(error.toString());
          if (error.toString().toLowerCase().contains('permission-denied')) {
            print("Handling user deletion");
            GetIt.I.get<AuthService>().handleUserDeletion(context);
          }
        },
      );
    } on FirebaseException catch (e) {
      log('Error fetching documents: ${e.message}');
      return emit(HomeFailure(FirebaseFailure.fromFirebaseException(e).errMsg));
    } catch (e) {
      log("Error at Home Cubit: ${e}");
      return emit(HomeFailure("حدث خطأ!!"));
    }
  }

  List<ProductModel> _parseProducts(Map<String, dynamic> data) {
    List<ProductModel> allProducts = [];
    for (var key in data.keys) {
      final fields = data[key];
      allProducts.add(ProductModel(
        identifierSN: key,
        productName: fields['modelName'],
        price: fields['price'] ?? 0,
        qty: fields['quantity'] ?? 0,
      ));
    }
    return allProducts;
  }
}
