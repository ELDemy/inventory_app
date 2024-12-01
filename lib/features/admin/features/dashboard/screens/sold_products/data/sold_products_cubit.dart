import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sold_products_state.dart';

class SoldProductsCubit extends Cubit<SoldProductsState> {
  SoldProductsCubit() : super(SoldProductsInitial());
}
