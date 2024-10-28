part of 'product_profile_cubit.dart';

@immutable
sealed class ProductProfileState {}

final class ProductProfileInitial extends ProductProfileState {}

final class ProductProfileLoading extends ProductProfileState {}

final class ProductProfileSuccess extends ProductProfileState {}

final class ProductProfileFailure extends ProductProfileState {
  final String errMsg;

  ProductProfileFailure(this.errMsg);
}

@immutable
sealed class DeleteProductState extends ProductProfileState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {}

final class DeleteProductFailure extends DeleteProductState {
  final String errMsg;

  DeleteProductFailure(this.errMsg);
}
