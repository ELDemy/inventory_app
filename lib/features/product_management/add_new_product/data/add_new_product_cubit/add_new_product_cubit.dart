import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/product_management_repo.dart';
import 'package:inventory_app/features/product_management/data/product_management_repo/service_state.dart';
import 'package:meta/meta.dart';

part 'add_new_product_state.dart';

class AddNewProductCubit extends Cubit<AddNewProductState> {
  AddNewProductCubit() : super(AddNewProductInitial());

  final ProductManagementRepo productManagementRepo =
      Injector.get<ProductManagementRepo>();

  Future addNewProduct(ProductModel productModel) async {
    if (!Injector.isOnline) {
      emit(AddProductFailure("برجاء التحقق من الاتصال بالانترنت"));
      return;
    }
    emit(AddProductLoading());
    try {
      ServiceState? serviceState =
          await productManagementRepo.addNewProductModel(productModel);
      if (serviceState == null) {
        emit(AddNewProductSuccess());
      } else {
        emit(AddProductFailure(serviceState.serviceStateMsg));
      }
    } on Exception {
      emit(
        AddProductFailure("حدث خطأ غير متوقع برجاء المحاوله مره اخرى!!"),
      );
    }
  }
}
