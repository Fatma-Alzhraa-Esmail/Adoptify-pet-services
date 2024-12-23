import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/favourites/repo/favourite_repo.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favouriteRepo) : super(FavouriteInitialState());
  final FavouriteRepo favouriteRepo;
  String userId = SharedHandler.instance!
      .getData(key: SharedKeys().user, valueType: ValueType.string);

  List<FavouriteModel> allFavouritesList = [];
  bool favouriteIsLoading = false;
  Map<String, List<FavouriteModel>> groupedFavorites = {};
  String selectedFeatureType = "";
  Future<void> addToFavourite({required FavouriteModel favouriteItem}) async {
    var addToFavourite = await favouriteRepo.addToFavourite(
        userId: userId, favouriteItem: favouriteItem);
    addToFavourite.fold((failure) {
      emit(AddFavouriteFailureState(errMessage: failure.errMessage));
    }, (success) {
      emit(AddFavouriteSuccessState());
      fetchAllFavourite();
    });
  }

  Future<void> removeFromFavourite(
      {required DocumentReference favItemDocRef}) async {
    var removeFromFavourite = await favouriteRepo.removeFromFavourite(
        userId: userId, favItemDocRef: favItemDocRef);
    removeFromFavourite.fold((failure) {
      emit(RemoveFavouriteFailureState(errMessage: failure.errMessage));
    }, (success) {
      emit(RemoveFavouriteSuccessState());
      fetchAllFavourite();
    });
  }

  Future<void> fetchAllFavourite() async {
    emit(FetchAllFavouritesLoadingtate());
    var addToFavourite = await favouriteRepo.fetchFavouriteList(
      userId: userId,
    );
    addToFavourite.fold((failure) {
      emit(FetchAllFavouritesErrorState(errMessage: failure.errMessage));
    }, (FavouritesList) {
      allFavouritesList = FavouritesList;
      emit(FetchAllFavouriteLoadedState(favouritesList: FavouritesList));
    });
  }

  Future<void> fetchProductDetails({required DocumentReference docRef}) async {
    emit(FetchProductDetailsLoadingState());
    var fetchProductItem =
        await favouriteRepo.fetchProductDetails(docRef: docRef);
    fetchProductItem.fold((failure) {
       emit(FetchProductDetailsFailureState(errMessage: failure.errMessage));
    }, (productItemDetails) {
      emit(FetchProductDetailsLoadedState(productItem: productItemDetails));
    });
  }

 Future<void> fetchTipsDetails({required DocumentReference docRef}) async {
    emit(FetchTipsLoadingState());
    var fetchTipsItem =
        await favouriteRepo.fetchTipsDetails(docRef: docRef);
    fetchTipsItem.fold((failure) {
       emit(FetchTipsDetailsFailureState(errMessage: failure.errMessage));
    }, (tipItemDetails) {
      emit(FetchTipsDetailsLoadedState(tipItem: tipItemDetails));
    });
  }
  Future<void> fetchFavorites() async {
    try {
      emit(FetchAllFavouritesLoadingtate());

      // Fetch all favourites
      await fetchAllFavourite();

      // Group by featureType
      groupedFavorites.clear();
      for (var item in allFavouritesList) {
        if (item.featureType != null && item.featureType.name != null) {
          groupedFavorites.putIfAbsent(item.featureType.name, () => []);
          groupedFavorites[item.featureType.name]!.add(item);
        }
      }

      // Set default selectedFeatureType
      if (groupedFavorites.isNotEmpty) {
        selectedFeatureType = groupedFavorites.keys.first;
      } else {
        selectedFeatureType = "";
      }

      emit(FavoritesLoaded(
        groupedFavorites: groupedFavorites,
        selectedFeatureType: selectedFeatureType,
      ));
    } catch (e, stacktrace) {
      print("Error: $e\nStacktrace: $stacktrace");
      emit(FavoritesError(errMessage: "Failed to fetch favorites"));
    }
  }

  void selectFeatureType(String featureType) {
    
      emit(FavoritesLoaded(
        groupedFavorites: groupedFavorites,
        selectedFeatureType: featureType,
      ));
    
  }
}
