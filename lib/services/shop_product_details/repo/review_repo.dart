import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/model/review_model.dart';

abstract class ReviewRepo {
   Future<Either<Failure, ReviewModel>> addReview(
      {required num rate,
      required String review,
      required List<String> imageUrlsList,
      required ProductModel productItem});
  Future<Either<Failure, List<String>>> uploadImages(
      List<File> images, String productId, String userId);
  Future<Either<Failure, void>> deleteImagesFromStorage(
      {required ProductModel productItem,required ReviewModel reviewItem});
  Future<Either<Failure, List<ReviewModel>>> getReviewsList(
     {required DocumentReference productRef,required ProductModel productItem });

      Future<Either<Failure, void>> updateReview(
      {required num rate,
      required String review,
      required List<String> imageUrlsList,
      required ProductModel productItem,
      required ReviewModel reviewItem,
      });
}