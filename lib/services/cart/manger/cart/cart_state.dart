part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitialState extends CartState {}

final class AddCartSuccessState extends CartState {}

final class AddCartFailureState extends CartState {
  final String errMessage;

  AddCartFailureState({required this.errMessage});
}

final class RemoveCartSuccessState extends CartState {}

final class RemoveCartFailureState extends CartState {
  final String errMessage;

  RemoveCartFailureState({required this.errMessage});
}

final class FetchAllCartLoadedState extends CartState {
  final List<CartModel> cartList;

  FetchAllCartLoadedState({required this.cartList});
}

final class FetchAllCartLoadingtate extends CartState {}

final class FetchAllCartErrorState extends CartState {
  final String errMessage;

  FetchAllCartErrorState({required this.errMessage});
}
