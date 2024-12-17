import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/repo/cart_repo.dart';
class CartRepoImpl implements CartRepo {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, void>> addToCart(
      {required String userId, required CartModel cartItem,required String color}) async {
    try {
      var addToCart = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .add(CartModel(
            productRef: cartItem.productRef,
            color: color
          ).toJson());
      print(addToCart);
      final docId = addToCart;
      await addToCart.update({'docRef': docId});

      // ignore: void_checks
      return right(0);
    } catch (e) {
      print("Error adding Cart: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> fetchCartList({
    required String userId,
  }) async {
    List<CartModel> allFavouriteList = [];

    try {
      var fetchCartListSnapShot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .get();

      print("Fetched Cart List Snapshot: $fetchCartListSnapShot");

      final cartList = fetchCartListSnapShot.docs.map((cartDoc) {
        print("favouriteDoc Data: ${cartDoc.data()}");
        return CartModel.fromJson(
          cartDoc.data(),
          FirebaseFirestore.instance,
        );
      }).toList();

      allFavouriteList.addAll(cartList);
      return right(allFavouriteList);
    } catch (e) {
      print("Error Fetching cartList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(
      {required String userId,
      required DocumentReference cartItemDocRef}) async {
    try {
      await cartItemDocRef.delete();

      return right(0);
    } catch (e) {
      print("Error remove Cart: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
