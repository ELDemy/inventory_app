import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/service_state.dart';
import 'package:meta/meta.dart';

part 'product_management_state.dart';

class ProductManagementCubit extends Cubit<ProductManagementState> {
  ProductManagementCubit() : super(ProductManagementInitial());

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  Future addNewProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(ProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(ProductLoading());
    try {
      ServiceState? serviceState =
          await productManagementRepo.addNewProductModel(productModel);
      if (serviceState == null) {
        emit(AddNewProductSuccess());
      } else {
        emit(ProductFailure(serviceState.serviceStateMsg));
      }
    } on Exception {
      emit(
        ProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخرى!!"),
      );
    }
  }

  Future<void> getProduct(String barcode) async {
    try {
      emit(ProductLoading());
      String identifierSN = BarcodeUtil.parseIdentifierFromSN(barcode);

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await productManagementRepo.getProduct(identifierSN);

      if (docSnapshot.exists) {
        final ProductModel product =
            ProductModel.fromFirestore(docSnapshot, null);
        emit(ProductLoaded(product));
      } else {
        emit(ProductFailure(
            "المنتج بمعرف رقم $identifierSN  غير موجود في قاعدة البيانات \n برجاء اضافة المنتج ثم اعادة المحاولة "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      emit(ProductFailure(
        FirebaseFailure.fromFirebaseException(firebaseException).errMsg,
      ));
    } catch (e) {
      print('An unexpected error occurred: $e');
      emit(ProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }
}
