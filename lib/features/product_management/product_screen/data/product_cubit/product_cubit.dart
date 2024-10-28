import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.identifierSN) : super(ProductInitial()) {
    fetchProduct();
  }

  final String identifierSN;

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  late ProductModel productModel;
  Future<void> fetchProduct() async {
    try {
      if (!Injector.isOnline) {
        return emit(ProductFailure("تأكد من الاتصال بالانترنت "));
      }
      emit(ProductLoading());

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await productManagementRepo.getProduct(identifierSN);

      if (docSnapshot.exists) {
        productModel = ProductModel.fromFirestore(docSnapshot.data(), null);
        return emit(ProductSuccess());
      } else {
        return emit(ProductFailure(
            "المنتج بمعرف رقم $identifierSN  غير موجود في قاعدة البيانات \n برجاء اضافة المنتج ثم اعادة المحاولة "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(
        ProductFailure(
            FirebaseFailure.fromFirebaseException(firebaseException).errMsg),
      );
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(
          ProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
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
      return emit(
          DeleteProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }
}
