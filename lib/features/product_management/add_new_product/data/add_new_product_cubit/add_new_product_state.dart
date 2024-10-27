part of 'add_new_product_cubit.dart';

@immutable
sealed class AddNewProductState {}

final class AddNewProductInitial extends AddNewProductState {}

final class AddProductLoading extends AddNewProductState {}

final class AddNewProductSuccess extends AddNewProductState {}

final class AddProductFailure extends AddNewProductState {
  final String errMsg;

  AddProductFailure(this.errMsg);
}
