part of 'find_order_cubit.dart';

@immutable
sealed class FindOrderState {}

final class FindOrderInitial extends FindOrderState {}

final class FindOrderLoading extends FindOrderState {}

final class FindOrderSuccess extends FindOrderState {}

final class FindOrderFailure extends FindOrderState {
  final String errMsg;

  FindOrderFailure(this.errMsg);
}
