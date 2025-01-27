import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/cart/model/cart_model.dart';
import 'package:peto_care/services/cart/repo/cart_repo.dart';
import 'package:peto_care/services/home/model/product_model.dart';

class CartRepoImpl implements CartRepo {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<Failure, void>> addToCart(
      {required String userId,
      required CartModel cartItem,
      required String color}) async {
    try {
      var addToCart = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Cart')
          .add(CartModel(
            productRef: cartItem.productRef,
            color: color,
            count: 1,
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

  @override
  Future<Either<Failure, double>> calculateTotalPrice(
      {required List<CartModel> cartItems}) async {
    try {
      double totalPrice = 0;

      // Iterate through each cart item
      for (var cartItem in cartItems) {
        // Fetch the product document using the document reference
        DocumentSnapshot productSnapshot =
            await cartItem.productRef // productRef is the document reference
                .get();

        if (productSnapshot.exists) {
          // Map the product data to ProductModel
          ProductModel product = ProductModel.fromJson(
              productSnapshot.data() as Map<String, dynamic>);

          // Calculate total price (price * count) and add it to totalPrice
          totalPrice += (product.price ?? 0) * (cartItem.count ?? 1);
          print("price $totalPrice");
        } else {
          return Left(FirebaseFailure(
              "Product not found for reference: ${cartItem.productRef}"));
        }
      }

      // Return the total price
      return Right(totalPrice);
    } catch (e) {
      print("Error calculating total price: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> incrementItemsCount(
      {required int count_in_stock, required CartModel cartItem}) async {
    try {
      if (cartItem.count <= count_in_stock) {
        var updatedCartItm =
            await cartItem.docRef?.update({'count': cartItem.count + 1});
        return right(cartItem.count + 1);
      } else {
        return Left(FirebaseFailure("out of stock"));
      }
    } catch (e) {
      print("Error calculating total price: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> decrementItemsCount(
      {required int count_in_stock, required CartModel cartItem}) async {
    try {
      if (cartItem.count <= count_in_stock && count_in_stock != 0 &&cartItem.count > 0) {
        var updatedCartItm =
            await cartItem.docRef?.update({'count': cartItem.count - 1});
        return right(cartItem.count - 1);
      } else {
        return Left(FirebaseFailure("out of stock"));
      }
    } catch (e) {
      print("Error calculating total price: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  bool isDuplicateItem({
    required List<CartModel> allCartItems,
    required CartModel cartItem,
    required String newColor,
  }) {
    // Check if there is a duplicate item in the list
    return allCartItems.any(
      (item) =>
          item.productRef == cartItem.productRef && item.color == newColor,
    );
  }

  CartModel? getDuplicateItem({
    required List<CartModel> allCartItems,
    required CartModel cartItem,
    required String newColor,
  }) {
    // Fetch the duplicate item, or return null if not found
    return allCartItems.firstWhere(
      (item) =>
          item.productRef == cartItem.productRef && item.color == newColor,
    );
  }

  @override
  Future<Either<Failure, CartModel>> updateItemColor({
    required List<CartModel> allCartItems,
    required CartModel cartItem,
    required String newColor,
  }) async {
    print("hello");
    print("allCartItems $allCartItems");
    print("cartItem $cartItem");
    print("newColor $newColor");
    try {
      // Check for duplicates
      if (isDuplicateItem(
        allCartItems: allCartItems,
        cartItem: cartItem,
        newColor: newColor,
      )) {
        print("Duplicate item found");

        // Fetch the duplicate item
        final duplicateItem = getDuplicateItem(
          allCartItems: allCartItems,
          cartItem: cartItem,
          newColor: newColor,
        );

        if (duplicateItem != null) {
          // Combine quantities
          var oldCount = cartItem.count;
          print("oldCount ${oldCount}");
          print("duplicateItem.count${duplicateItem.count}");
         int totalCount= duplicateItem.count + oldCount;
          await duplicateItem.docRef?.update({
            'count': totalCount,
            'color':newColor
          });

          // Optionally remove the old item
          await cartItem.docRef?.delete();

          return Right(CartModel.fromJson(
              duplicateItem.toJson())); // Return the updated quantity
        }
        return right(CartModel.fromJson(duplicateItem!.toJson()));
      } else {
        print("No duplicate found, updating item color");

        // Update the color of the existing item
        await cartItem.docRef?.update({
          'color': newColor,
        });

        return right(CartModel.fromJson(cartItem.toJson()));
      }
    } catch (e) {
      print("Error occurred: $e");
      return Left(FirebaseFailure(e.toString()));
    }
  }


}
