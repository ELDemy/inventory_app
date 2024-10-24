part of 'add_new_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddNewProductInitial extends AddProductState {}

final class AddNewProductLoading extends AddProductState {}

final class AddNewProductSuccess extends AddProductState {}

final class AddNewProductFailure extends AddProductState {}
