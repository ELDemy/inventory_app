import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddNewProductCubit extends Cubit<AddProductState> {
  AddNewProductCubit() : super(AddProductInitial());
}
