part of 'product_management_cubit.dart';

@immutable
sealed class ProductManagementState {}

final class ProductManagementInitial extends ProductManagementState {}

final class ProductLoading extends ProductManagementState {}

final class ProductFailure extends ProductManagementState {
  final String errMsg;

  ProductFailure(this.errMsg);
}

final class AddNewProductSuccess extends ProductManagementState {}

final class ProductLoaded extends ProductManagementState {
  final ProductModel productModel;

  ProductLoaded(this.productModel);
}
