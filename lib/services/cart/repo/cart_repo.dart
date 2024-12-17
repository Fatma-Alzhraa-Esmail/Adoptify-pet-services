import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';

abstract class CartRepo {
   Future<Either<Failure, void>> addToCart({required String userId,required CartModel cartItem,required String color});
  Future<Either<Failure, void>> removeFromCart({required String userId,required DocumentReference cartItemDocRef,});
  Future<Either<Failure, List<CartModel>>> fetchCartList({required String userId,});
}