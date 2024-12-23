import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';

abstract class FavouriteRepo {
  Future<Either<Failure, void>> addToFavourite(
      {required String userId, required FavouriteModel favouriteItem});
  Future<Either<Failure, void>> removeFromFavourite({
    required String userId,
    required DocumentReference favItemDocRef,
  });
  Future<Either<Failure, List<FavouriteModel>>> fetchFavouriteList({
    required String userId,
  });
  Future<Either<Failure, ProductModel>> fetchProductDetails(
      {required DocumentReference docRef});
       Future<Either<Failure, TipsModel>> fetchTipsDetails(
      {required DocumentReference docRef});
}
