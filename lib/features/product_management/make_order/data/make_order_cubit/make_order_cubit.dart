import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/utils/barcode_util.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'make_order_state.dart';

class MakeOrderCubit extends Cubit<MakeOrderState> {
  MakeOrderCubit(this.barcode) : super(MakeOrderInitial()) {
    fetchProduct();
  }

  String barcode;
  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();
  late ProductModel productModel;

  Future<void> fetchProduct() async {
    try {
      emit(OrderLoading());
      String identifierSN = BarcodeUtil.parseIdentifierFromSN(barcode);

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await productManagementRepo.getProduct(identifierSN);

      if (docSnapshot.exists) {
        productModel = ProductModel.fromFirestore(docSnapshot, null);
        emit(OrderLoaded());
      } else {
        emit(OrderFailure(
            "المنتج بمعرف رقم $identifierSN  غير موجود في قاعدة البيانات \n برجاء اضافة المنتج ثم اعادة المحاولة "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      emit(OrderFailure(
        FirebaseFailure.fromFirebaseException(firebaseException).errMsg,
      ));
    } catch (e) {
      print('An unexpected error occurred: $e');
      emit(OrderFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }
}
