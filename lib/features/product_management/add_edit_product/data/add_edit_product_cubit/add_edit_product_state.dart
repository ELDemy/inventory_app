part of 'add_edit_product_cubit.dart';

@immutable
sealed class AddEditProductState {}

final class AddEditProductInitial extends AddEditProductState {}

final class AddEditProductLoading extends AddEditProductState {}

final class AddEditProductSuccess extends AddEditProductState {}

final class AddEditProductFailure extends AddEditProductState {
  final String errMsg;

  AddEditProductFailure(this.errMsg);
}
