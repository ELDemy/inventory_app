import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(EditProductInitial());
}
