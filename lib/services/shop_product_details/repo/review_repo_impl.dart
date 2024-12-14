import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/model/review_model.dart';
import 'package:peto_care/services/shop_product_details/repo/review_repo.dart';

class ReviewRepoImpl implements ReviewRepo {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<Either<Failure, List<String>>> uploadImages(
      List<File> images, String productId, String userId) async {
    List<String> imageUrls = [];
    for (var image in images) {
      String fileName =
          'reviews/$productId/$userId/${image.path.split('/').last}';
      try {
        final ref = _firebaseStorage.ref(fileName);
        final uploadTask = await ref.putFile(image);
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } catch (e) {
        print("Error uploading image: $e");
        print("Error adding review: $e");
        if (e is FirebaseException) {
          return Left(FirebaseFailure.fromFirebaseError(e.toString()));
        }
        return Left(FirebaseFailure(e.toString()));
      }
    }
    return right(imageUrls);
  }

  @override
  Future<Either<Failure, ReviewModel>> addReview({
    required num rate,
    required String review,
    required List<String> imageUrlsList,
    required ProductModel productItem,
  }) async {
    try {
      String userId = SharedHandler.instance!
          .getData(key: SharedKeys().user, valueType: ValueType.string);
      final reviewData = ReviewModel(
        user_id: userId,
        user_rate: rate,
        comment: review,
        images: imageUrlsList,
        review_id: '',
        created_at: DateTime.now(),
      ).toJson();
      final reviewsCollection = productItem.docRef.collection('Reviews');
      final reviewDocRef = await reviewsCollection.add(reviewData);
      final docId = reviewDocRef.id;
      await reviewDocRef.update({'review_id': docId});
      reviewData['review_id'] = docId;
      return Right(ReviewModel.fromJson(reviewData));
    } catch (e) {
      print("Error adding review: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviewsList(
      {required DocumentReference productRef,
      required ProductModel productItem}) async {
    try {
      List<ReviewModel> allReviews = [];
      var reviewSnapShot = await productItem.docRef.collection('Reviews').get();
      final reviewsList = reviewSnapShot.docs.map((reviewDoc) {
        print("reviewDoc Data: ${reviewDoc.data()}");
        return ReviewModel.fromJson(reviewDoc.data());
      }).toList();
      allReviews.addAll(reviewsList);
      return right(allReviews);
    } catch (e) {
      print("Error Get reviewsList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReview(
      {required num rate,
      required String review,
      required List<String> imageUrlsList,
      required ProductModel productItem,
      required ReviewModel reviewItem}) async {
    try {
      var getCurrentReviewDoc =
          productItem.docRef.collection('Reviews').doc(reviewItem.review_id);
      var updatedReview = await getCurrentReviewDoc.update({
        'user_rate': rate,
        'images': imageUrlsList,
        'comment': review,
      });
      return right(0);
    } catch (e) {
      print("Error adding review: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImagesFromStorage(
      {required ProductModel productItem,
      required ReviewModel reviewItem}) async {
    final reviewDocRef =
        productItem.docRef.collection('Reviews').doc(reviewItem.review_id);

    try {
      if (reviewItem.images!.isNotEmpty || reviewItem.images!.length != 0){
        for (String imageUrl in reviewItem.images!) {
          final ref = _firebaseStorage.refFromURL(imageUrl);
          await ref.delete();
        }
      }
      return right(null);

    } catch (e) {
      print("Error adding review: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
