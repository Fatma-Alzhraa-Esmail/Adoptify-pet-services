import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(
      {required String userId,
      required CartModel cartItem,
      required String color});
  Future<Either<Failure, void>> removeFromCart({
    required String userId,
    required DocumentReference cartItemDocRef,
  });
  Future<Either<Failure, List<CartModel>>> fetchCartList({
    required String userId,
  });
  Future<Either<Failure, double>> calculateTotalPrice(
      {required List<CartModel> cartItems});
  Future<Either<Failure, int>> incrementItemsCount(
      {required int count_in_stock,required CartModel cartItem});
  Future<Either<Failure, int>> decrementItemsCount(
      {required int count_in_stock,required CartModel cartItem});
       Future<Either<Failure, CartModel>> updateItemColor(
      {required List<CartModel> allCartItems,required CartModel cartItem, required String newColor,});
}
