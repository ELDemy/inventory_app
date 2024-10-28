part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {}

final class ProductFailure extends ProductState {
  final String errMsg;

  ProductFailure(this.errMsg);
}

@immutable
sealed class DeleteProductState extends ProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {}

final class DeleteProductFailure extends DeleteProductState {
  final String errMsg;

  DeleteProductFailure(this.errMsg);
}
