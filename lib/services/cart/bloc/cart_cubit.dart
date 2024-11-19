import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/cart/bloc/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartIntaialState());
  static CartCubit get(context) => BlocProvider.of(context);
  int counter = 0;
  add() {
    counter++;
    emit(CartAddState());
  }

  remove() {
    if (counter > 0) {
      counter--;
    }
    emit(CartRemoveState());
  }

  bool isSelected = false;
  choosePaymentMethod() {
    isSelected = true;
  }
}
