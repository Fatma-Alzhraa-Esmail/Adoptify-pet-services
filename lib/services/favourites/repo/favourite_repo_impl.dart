import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/favourites/repo/favourite_repo.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';

class FavouriteRepoImpl implements FavouriteRepo {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, void>> addToFavourite(
      {required String userId, required FavouriteModel favouriteItem}) async {
    try {
      var addToFavourite = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Favourites')
          .add(FavouriteModel(
            featureType: favouriteItem.featureType,
            docRef: favouriteItem.docRef,
          ).toJson());
      print(addToFavourite);
      final docId = addToFavourite;
      await addToFavourite.update({'FavouritedocRef': docId});

      // ignore: void_checks
      return right(0);
    } catch (e) {
      print("Error adding favourite: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavouriteModel>>> fetchFavouriteList({
    required String userId,
  }) async {
    List<FavouriteModel> allFavouriteList = [];

    try {
      var fetchFavouriteListSnapShot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Favourites')
          .get();

      print("Fetched Favourite List Snapshot: $fetchFavouriteListSnapShot");

      final FavouriteList = fetchFavouriteListSnapShot.docs.map((favouriteDoc) {
        print("favouriteDoc Data: ${favouriteDoc.data()}");
        return FavouriteModel.fromJson(
          favouriteDoc.data(),
          FirebaseFirestore.instance,
        );
      }).toList();

      allFavouriteList.addAll(FavouriteList);
      return right(allFavouriteList);
    } catch (e) {
      print("Error Fetching favouriteList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavourite(
      {required String userId,
      required DocumentReference favItemDocRef}) async {
    try {
      await favItemDocRef.delete();

      return right(0);
    } catch (e) {
      print("Error remove favourite: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> fetchProductDetails(
      {required DocumentReference docRef}) async {
    try {
      var docsnapShot = await docRef.get();
      ProductModel productItem = ProductModel.fromJson(docsnapShot.data() as Map<String, dynamic>);
      return right(productItem);
    } catch (e) {
      print("Error fetch product: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TipsModel>> fetchTipsDetails({required DocumentReference<Object?> docRef}) async{
    try {
      var docsnapShot = await docRef.get();
      TipsModel tipsItem = TipsModel.fromJson(docsnapShot.data() as Map<String, dynamic>);
      return right(tipsItem);
    } catch (e) {
      print("Error fetch tips: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
