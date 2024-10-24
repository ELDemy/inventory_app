import 'package:bloc/bloc.dart';
import 'package:inventory_app/core/models/product_model.dart';
import 'package:inventory_app/core/services/firebase_service.dart';
import 'package:meta/meta.dart';

part 'add_new_product_state.dart';

class AddNewProductCubit extends Cubit<AddProductState> {
  AddNewProductCubit() : super(AddNewProductInitial());

  Future addNewProduct(ProductModel productModel) async {
    emit(AddNewProductLoading());
    await MyFirebaseService().addNewModel(productModel);
    emit(AddNewProductSuccess());
  }

  emitLoading() {
    emit(AddNewProductLoading());
  }
}
