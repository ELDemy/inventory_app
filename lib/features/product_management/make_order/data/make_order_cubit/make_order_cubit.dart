import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/order_model.dart';
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
      emit(ProductLoading());

      String identifierSN = BarcodeUtil.parseIdentifierFromSN(barcode);
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await productManagementRepo.getProduct(identifierSN);

      if (docSnapshot.exists) {
        productModel = ProductModel.fromFirestore(docSnapshot, null);
        return emit(ProductLoaded());
      } else {
        return emit(ProductFailure(
            "المنتج بمعرف رقم $identifierSN  غير موجود في قاعدة البيانات \n برجاء اضافة المنتج ثم اعادة المحاولة "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(ProductFailure(
        FirebaseFailure.fromFirebaseException(firebaseException).errMsg,
      ));
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(
          ProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> makeOrder(OrderModel orderModel) async {
    try {
      emit(OrderLoading());

      await productManagementRepo.makeOrder(orderModel).then(
        (value) {
          print('Order Transaction has been created successfully.');
          return emit(OrderSuccess());
        },
      ).onError(
        (error, stackTrace) {
          emit(OrderFailure("خطأ! برجاء اعادة المحاوله"));
        },
      );
    } on FirebaseException catch (firebaseException) {
      print('Error creating document: ${firebaseException.message}');
      return emit(OrderFailure(
        FirebaseFailure.fromFirebaseException(firebaseException).errMsg,
      ));
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(OrderFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }
}
