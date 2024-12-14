import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/handlers/file_picker_handler.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/model/review_model.dart';
import 'package:peto_care/services/shop_product_details/repo/review_repo.dart';
part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(
    this.reviewsRepo,
  ) : super(ReviewsInitial());
  final ReviewRepo reviewsRepo;
  bool reviewIsLoading = true;
  List<ReviewModel> ReviewsList = [];
  List<File> images = [];
  TextEditingController reviewController = TextEditingController();
  num rate = 0.0;
  bool isEdit = false;
  bool isUpdatingReview = false;
  void changeRate(num ratedChanged) {
    rate = ratedChanged;
    emit(ProductRateChangeState(rate: ratedChanged));
  }

  void askToEditReview({
    required String comment,
    required num currentRate,
  }) {
    isEdit = true;
    reviewController.text = comment;
    rate = currentRate;
    emit(AskToEditReviewState());
  }

  Future<void> selectImages() async {
    var images = await FilePickerHelper.pickImages(
      onSelected: (value) {
        print("values: ${value}");
        emit(SelectedImagesState(images: value));
      },
    );
  }

  Future<ReviewModel?> addReview({required ProductModel productId}) async {
    String reviewId = SharedHandler.instance!
        .getData(key: SharedKeys().user, valueType: ValueType.string);

    var uploadImagesToFireStorage =
        await reviewsRepo.uploadImages(images, productId.id, reviewId);
    uploadImagesToFireStorage.fold((failure) {
      emit(UploadedImagesErrorState(errMessage: failure.errMessage));
    }, (imagesList) async {
      var addReview = await reviewsRepo.addReview(
          rate: rate,
          review: reviewController.text,
          imageUrlsList: imagesList,
          productItem: productId);
      addReview.fold(
        (failure) {
          emit(UploadedImagesErrorState(errMessage: failure.errMessage));
        },
        (reviewItem) {
          emit(ReviewAddSuccessfullyState(reviewItem: reviewItem));
        },
      );
    });
  }

  Future<ReviewModel?> updateReview(
      {required ProductModel productItem,
      required ReviewModel reviewItem}) async {
    isUpdatingReview = true;
    String reviewId = SharedHandler.instance!
        .getData(key: SharedKeys().user, valueType: ValueType.string);
    var removeImagesFromfireStorage = await reviewsRepo.deleteImagesFromStorage(
        productItem: productItem, reviewItem: reviewItem);
    removeImagesFromfireStorage.fold((failure) {
      emit(UploadedImagesErrorState(errMessage: failure.errMessage));
    }, (success) async {
      var uploadImagesToFireStorage =
          await reviewsRepo.uploadImages(images, productItem.id, reviewId);
      uploadImagesToFireStorage.fold((failure) {
        emit(UploadedImagesErrorState(errMessage: failure.errMessage));
      }, (imagesList) async {
        var addReview = await reviewsRepo.updateReview(
          imageUrlsList: imagesList,
          productItem: productItem,
          rate: rate,
          review: reviewController.text,
          reviewItem: reviewItem,
        );
        addReview.fold(
          (failure) {
            emit(ReviewsUpdatedFailureState(errMeassge: failure.errMessage));
          },
          (reviewItem) {
            emit(ReviewsUpdatedSuccessFullyState());
            isEdit = false;
            isUpdatingReview = false;
            fetchReviews(
                productRef: productItem.docRef, productItem: productItem);
          },
        );
      });
    });
  }

  Future<List<ReviewModel>?> fetchReviews(
      {required DocumentReference productRef,
      required ProductModel productItem}) async {
    reviewIsLoading = true;
    var getReviews = await reviewsRepo.getReviewsList(
      productItem: productItem,
      productRef: productRef,
    );
    getReviews.fold(
      (failure) {
        emit(ReviewsErrorState(errMeassge: failure.errMessage));
      },
      (reviewItem) {
        print("From here reviewList ${reviewItem}");
        emit(ReviewsLoadedState(reviewsList: reviewItem));
        reviewIsLoading = false;
      },
    );
  }
}
