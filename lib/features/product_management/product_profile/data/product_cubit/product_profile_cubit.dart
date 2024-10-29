import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/shared/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'product_profile_state.dart';

class ProductProfileCubit extends Cubit<ProductProfileState> {
  ProductProfileCubit(this.identifierSN) : super(ProductProfileInitial()) {
    fetchProduct();
  }

  final String identifierSN;

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  late ProductModel productModel;
  Future<void> fetchProduct() async {
    try {
      if (!Injector.isOnline) {
        return emit(ProductProfileFailure("تأكد من الاتصال بالانترنت "));
      }
      emit(ProductProfileLoading());

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await productManagementRepo.getProduct(identifierSN);

      if (docSnapshot.exists) {
        productModel = ProductModel.fromFirestore(docSnapshot.data(), null);
        return emit(ProductProfileSuccess());
      } else {
        return emit(ProductProfileFailure(
            "المنتج بمعرف رقم $identifierSN  غير موجود في قاعدة البيانات \n برجاء اضافة المنتج ثم اعادة المحاولة "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(
        ProductProfileFailure(
            FirebaseFailure.fromFirebaseException(firebaseException).errMsg),
      );
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(ProductProfileFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> deleteProduct() async {
    try {
      if (!Injector.isOnline) {
        return emit(DeleteProductFailure("تأكد من الاتصال بالانترنت "));
      }
      emit(DeleteProductLoading());

      await productManagementRepo.deleteProduct(identifierSN);
      emit(DeleteProductSuccess());
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(
        DeleteProductFailure(
            FirebaseFailure.fromFirebaseException(firebaseException).errMsg),
      );
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(DeleteProductFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }
}
