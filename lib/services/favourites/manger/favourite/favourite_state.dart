part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitialState extends FavouriteState {}

final class AddFavouriteSuccessState extends FavouriteState {}

final class AddFavouriteFailureState extends FavouriteState {
  final String errMessage;

  AddFavouriteFailureState({required this.errMessage});
}

final class RemoveFavouriteSuccessState extends FavouriteState {}

final class RemoveFavouriteFailureState extends FavouriteState {
  final String errMessage;

  RemoveFavouriteFailureState({required this.errMessage});
}

final class FetchAllFavouriteLoadedState extends FavouriteState {
  final List<FavouriteModel> favouritesList;

  FetchAllFavouriteLoadedState({required this.favouritesList});
}

final class FetchAllFavouritesLoadingtate extends FavouriteState {}

final class FetchAllFavouritesErrorState extends FavouriteState {
  final String errMessage;

  FetchAllFavouritesErrorState({required this.errMessage});
}

final class FavoritesLoaded extends FavouriteState {
  final Map<String, List<FavouriteModel>> groupedFavorites;
  final String selectedFeatureType;

  FavoritesLoaded(
      {required this.groupedFavorites, required this.selectedFeatureType});
}

final class FavoritesError extends FavouriteState {
  final String errMessage;

  FavoritesError({required this.errMessage});
}

final class FetchProductDetailsLoadingState extends FavouriteState {}

final class FetchProductDetailsLoadedState extends FavouriteState {
  final ProductModel productItem;

  FetchProductDetailsLoadedState({required this.productItem});
}

final class FetchProductDetailsFailureState extends FavouriteState {
  final String errMessage;

  FetchProductDetailsFailureState({required this.errMessage});
}
