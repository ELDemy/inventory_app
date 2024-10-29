import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/shared/data/product_management_repo/product_management_repo.dart';
import 'package:meta/meta.dart';

part 'find_order_state.dart';

class FindOrderCubit extends Cubit<FindOrderState> {
  FindOrderCubit(this.barcode) : super(FindOrderInitial()) {
    fetchOrder();
  }

  String barcode;

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  late OrderModel orderModel;

  Future<void> fetchOrder() async {
    try {
      emit(FindOrderLoading());

      QuerySnapshot<Map<String, dynamic>> qSnapshot =
          await productManagementRepo.getOrder(barcode);

      if (qSnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot = qSnapshot.docs[0];
        orderModel = OrderModel.fromFirestore(
          docSnapshot.data(),
          docSnapshot.id,
          null,
        );

        return emit(FindOrderSuccess());
      } else {
        return emit(FindOrderFailure(
            "المنتج رقم $barcodeغير موجود في قاعدة البيانات "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(FindOrderFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(FindOrderFailure("حدث خطأ !! برجاء المحاوله مره اخري!!"));
    }
  }
}
