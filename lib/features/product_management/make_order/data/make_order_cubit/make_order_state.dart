part of 'make_order_cubit.dart';

@immutable
sealed class MakeOrderState {}

final class MakeOrderInitial extends MakeOrderState {}

@immutable
sealed class FetchProductState extends MakeOrderState {}

final class ProductLoading extends FetchProductState {}

final class ProductLoaded extends FetchProductState {}

final class ProductFailure extends FetchProductState {
  final String errMsg;

  ProductFailure(this.errMsg);
}

@immutable
sealed class MakingOrderState extends MakeOrderState {}

final class MakeOrderLoading extends MakingOrderState {}

final class MakeOrderSuccess extends MakingOrderState {}

final class MakeOrderFailure extends MakingOrderState {
  final String errMsg;

  MakeOrderFailure(this.errMsg);
}
