import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/features/product_management/data/service/product_management_service.dart';
import 'package:inventory_app/features/product_management/data/service/service_state.dart';
import 'package:meta/meta.dart';

part 'add_new_product_state.dart';

class AddNewProductCubit extends Cubit<AddProductState> {
  AddNewProductCubit() : super(AddNewProductInitial());

  Future addNewProduct(ProductModel productModel) async {
    emit(AddNewProductLoading());
    try {
      ServiceState? serviceState =
          await ProductManagementService().addNewProductModel(productModel);
      if (serviceState == null) {
        emit(AddNewProductSuccess());
      } else {
        emit(AddNewProductFailure(errMsg: serviceState.serviceStateMsg));
      }
    } on Exception {
      emit(
        AddNewProductFailure(
            errMsg: "حدث خطأ غير متوقع برجاء المحاوله مره اخرى!!"),
      );
    }
  }

  emitLoading() {
    emit(AddNewProductLoading());
  }
}
