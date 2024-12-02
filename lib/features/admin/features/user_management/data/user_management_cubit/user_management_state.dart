part of 'user_management_cubit.dart';

@immutable
sealed class UserManagementState {}

final class UserManagementInitial extends UserManagementState {}

final class UserManagementLoading extends UserManagementState {}

final class UserManagementSuccess extends UserManagementState {}

final class UserManagementFailure extends UserManagementState {
  final String errMsg;

  UserManagementFailure(this.errMsg);
}

@immutable
sealed class UserSignUpState extends UserManagementState {}

final class UserSignUpLoading extends UserSignUpState {}

final class UserSignUpSuccess extends UserSignUpState {}

final class UserSignUpFailure extends UserSignUpState {
  final String errMsg;

  UserSignUpFailure(this.errMsg);
}
