import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/shared/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(AddEditProductInitial());

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  Future<void> addNewProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(AddEditProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(AddEditProductLoading());
    try {
      // check if the product is already exists
      DocumentSnapshot<Map<String, dynamic>> doc =
          await productManagementRepo.getProduct(productModel.identifierSN!);

      if (doc.exists) {
        print('Document with ID ${productModel.identifierSN} already exists.');
        return emit(AddEditProductFailure(
            "المنتج رقم ${productModel.identifierSN} موجود بالفعل "));
      }

      await productManagementRepo.addProduct(productModel);

      emit(AddEditProductSuccess());
    } on FirebaseException catch (firebaseException) {
      return emit(AddEditProductFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      Failure.exception(e);
      return emit(AddEditProductFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> updateProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(AddEditProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(AddEditProductLoading());
    try {
      await productManagementRepo.addProduct(productModel);
      emit(AddEditProductSuccess());
    } on FirebaseException catch (firebaseException) {
      return emit(AddEditProductFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      Failure.exception(e);
      return emit(AddEditProductFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> addNewCategory(String category) async {
    try {
      await productManagementRepo.addCategory(category);
    } catch (e) {
      Failure.exception(e);
    }
  }
}
