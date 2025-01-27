import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/repo/cart_repo.dart';
import 'package:peto_care/services/home/model/product_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitialState());
  final CartRepo cartRepo;
  String userId = SharedHandler.instance!
      .getData(key: SharedKeys().user, valueType: ValueType.string);

  List<CartModel> allCartList = [];
  bool cartIsLoading = false;
  bool addRemoveIsLoading = false;
  double price = 0.0;
  double delivery = 5.0;
 String selectedColor='';
  Future<void> addToCart({required CartModel cartItem}) async {
    addRemoveIsLoading = true;
    var addToCart = await cartRepo.addToCart(
        userId: userId, cartItem: cartItem, color: cartItem.color);
    addToCart.fold((failure) {
      emit(AddCartFailureState(errMessage: failure.errMessage));
      addRemoveIsLoading = false;
    }, (success) {
      emit(AddCartSuccessState());
      addRemoveIsLoading = false;

      fetchAllCart();
    });
  }

  Future<void> removeFromCart(
      {required DocumentReference cartItemDocRef}) async {
    addRemoveIsLoading = true;

    var removeFromCart = await cartRepo.removeFromCart(
        userId: userId, cartItemDocRef: cartItemDocRef);
    removeFromCart.fold((failure) {
      emit(RemoveCartFailureState(errMessage: failure.errMessage));
      addRemoveIsLoading = false;
    }, (success) {
      emit(RemoveCartSuccessState());
      addRemoveIsLoading = false;

      fetchAllCart();
    });
  }

  Future<void> fetchAllCart() async {
    emit(FetchAllCartLoadingtate());
    var fetchDromCart = await cartRepo.fetchCartList(
      userId: userId,
    );
    fetchDromCart.fold((failure) {
      emit(FetchAllCartErrorState(errMessage: failure.errMessage));
    }, (CartList) {
      emit(FetchAllCartLoadedState(cartList: CartList));
      calculateTotalPrice(CartList);
    });
  }

  Future<void> calculateTotalPrice(List<CartModel> cartItems) async {
    emit(CalculateTotalPriceLoadingState());
    var fetchDromCart = await cartRepo.calculateTotalPrice(
      cartItems: cartItems,
    );
    fetchDromCart.fold((failure) {
      emit(CalculateTotalPriceErrorState(errMessage: failure.errMessage));
    }, (totalPrice) {
      price = totalPrice;
      emit(CalculateTotalPriceLoadedState(price: totalPrice));
    });
  }

  Future<void> incrementAndDecremnetItemCount(
      {required CartModel cartItem,
      required bool isIncreament,
      required int itemInStock}) async {
    var editItemCount;
    if (isIncreament) {
      editItemCount = await cartRepo.incrementItemsCount(
        cartItem: cartItem,
        count_in_stock: itemInStock,
      );
    } else {
      editItemCount = await cartRepo.decrementItemsCount(
        cartItem: cartItem,
        count_in_stock: itemInStock,
      );
    }
    editItemCount.fold((failure) {
      emit(editItemCountFailureState(errMessage: failure.errMessage));
    }, (itemChanged) {
      emit(editItemCountSuccessState());
      fetchAllCart();
      calculateTotalPrice(allCartList);
    });
  }
  Future<void> updateItemColor(
      {required CartModel cartItem,
      required String color,
     }) async {
    var editItemCount;
    fetchAllCart();
      editItemCount = await cartRepo.updateItemColor(
        cartItem: cartItem,
        allCartItems:allCartList ,
        newColor: color,
      );
    
    editItemCount.fold((failure) {
      emit(editItemColorFailureState(errMessage: failure.errMessage));
    }, (itemChanged) {
      emit(editItemColorSuccessState());
      fetchAllCart();
      calculateTotalPrice(allCartList);
    });
  }
}
