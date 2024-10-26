import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/service/product_management_service.dart';
import 'package:inventory_app/features/product_management/data/service/service_state.dart';
import 'package:meta/meta.dart';

part 'product_management_state.dart';

class ProductManagementCubit extends Cubit<ProductManagementState> {
  ProductManagementCubit() : super(ProductManagementInitial());

  Future addNewProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(ProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(ProductLoading());
    try {
      ServiceState? serviceState =
          await ProductManagementService().addNewProductModel(productModel);
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
}
