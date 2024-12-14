part of 'reviews_cubit.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

class SelectedImagesState extends ReviewsState {
  final List<File> images;

  SelectedImagesState({required this.images});
}

class UploadedImagesErrorState extends ReviewsState {
  final String errMessage;

  UploadedImagesErrorState({required this.errMessage});
}

class ReviewAddSuccessfullyState extends ReviewsState {
  final ReviewModel reviewItem;

  ReviewAddSuccessfullyState({required this.reviewItem});
}

class ProductRateChangeState extends ReviewsState {
  final num rate;

  ProductRateChangeState({required this.rate});
}

final class ReviewsLoadingState extends ReviewsState {}

final class ReviewsLoadedState extends ReviewsState {
  final List<ReviewModel> reviewsList;

  ReviewsLoadedState({required this.reviewsList});
}

final class ReviewsErrorState extends ReviewsState {
  final String errMeassge;

  ReviewsErrorState({required this.errMeassge});
}

final class ReviewsUpdatedSuccessFullyState extends ReviewsState {}

final class ReviewsUpdatedFailureState extends ReviewsState {
  final String errMeassge;

  ReviewsUpdatedFailureState({required this.errMeassge});
}

final class AskToEditReviewState extends ReviewsState {
  AskToEditReviewState();
}
