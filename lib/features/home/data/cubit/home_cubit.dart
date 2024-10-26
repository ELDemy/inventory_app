import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/show_info_util.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/home/data/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getProductModelsStream();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  List<ProductModel> products = [];

  @override
  Future<void> close() {
    _subscription?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }

  getProductModelsStream() {
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
      _subscription = HomeRepo().getProductsStream().listen(
        (snapshot) {
          final Map<String, dynamic>? data = snapshot.data();
          if (data != null) {
            products = _parseProducts(data);
            emit(HomeProductsState());
          }
        },
        onError: (error) {
          emit(HomeFailure(error.toString()));
        },
      );
    } catch (e) {
      print("Error at Home Cubit: ${e}");
      emit(HomeFailure(e.toString()));
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
