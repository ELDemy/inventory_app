part of 'make_order_cubit.dart';

@immutable
sealed class MakeOrderState {}

final class MakeOrderInitial extends MakeOrderState {}

final class OrderLoading extends MakeOrderState {}

final class OrderFailure extends MakeOrderState {
  final String errMsg;

  OrderFailure(this.errMsg);
}

final class OrderLoaded extends MakeOrderState {}
