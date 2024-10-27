import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/order_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
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
      print("ELDEMY qSnapshot ::${qSnapshot.size}");

      if (qSnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot =
            qSnapshot.docs[0];
        print("ELDEMY ::${docSnapshot}");
        orderModel = OrderModel.fromFirestore(docSnapshot, null);
        return emit(FindOrderSuccess());
      } else {
        return emit(FindOrderFailure(
            "المنتج بمعرف رقم $barcode  غير موجود في قاعدة البيانات \n "));
      }
    } on FirebaseException catch (firebaseException) {
      print('Error getting document: ${firebaseException.message}');
      return emit(FindOrderFailure(
        FirebaseFailure.fromFirebaseException(firebaseException).errMsg,
      ));
    } catch (e) {
      print('An unexpected error occurred: $e');
      return emit(
          FindOrderFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخري!!"));
    }
  }
}
