import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'add_new_product_state.dart';

class AddNewProductCubit extends Cubit<AddNewProductState> {
  AddNewProductCubit() : super(AddNewProductInitial());

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  Future<void> addNewProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(AddProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(AddProductLoading());
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await productManagementRepo.getProduct(productModel.identifierSN!);

      if (doc.exists) {
        print('Document with ID ${productModel.identifierSN} already exists.');
        return emit(AddProductFailure(
            "المنتج رقم ${productModel.identifierSN} موجود بالفعل "));
      }

      await productManagementRepo.addProduct(productModel);

      emit(AddNewProductSuccess());
    } on FirebaseException catch (firebaseException) {
      log('Error creating document: ${firebaseException.message}');
      return emit(AddProductFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      log('An unexpected error occurred: $e');
      return emit(AddProductFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> updateProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(AddProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(AddProductLoading());
    try {
      await productManagementRepo.addProduct(productModel);
      emit(AddNewProductSuccess());
    } on FirebaseException catch (firebaseException) {
      log('Error creating document: ${firebaseException.message}');
      return emit(AddProductFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      log('An unexpected error occurred: $e');
      return emit(AddProductFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }
}
