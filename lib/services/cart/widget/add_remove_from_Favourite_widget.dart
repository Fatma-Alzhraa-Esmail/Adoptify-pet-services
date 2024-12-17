import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/favourites/manger/favourite/favourite_cubit.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/favourites/repo/favourite_repo_impl.dart';
import 'package:peto_care/services/home/model/product_model.dart';

class AddRemoveFromFavouriteWidget extends StatelessWidget {
  const AddRemoveFromFavouriteWidget({
    super.key,
    required this.productItem,
    required this.featureType,
   this.padding,
   this.iconSize,
  });

  final ProductModel productItem;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final FeatureType featureType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit(FavouriteRepoImpl())
        ..fetchAllFavourite(),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          FavouriteCubit favouriteCubit =
              context.read<FavouriteCubit>();
          if (state is AddFavouriteFailureState) {
            print(state.errMessage);
          } else if (state is AddFavouriteSuccessState) {
          } else if (state is FetchAllFavouritesLoadingtate) {
          } else if (state is FetchAllFavouriteLoadedState) {
            favouriteCubit.allFavouritesList =
                state.favouritesList;
          } else if (state is FetchAllFavouritesErrorState) {
          } else if (state is RemoveFavouriteFailureState) {
          } else if (state is RemoveFavouriteSuccessState) {}
        },
        builder: (context, state) {
          FavouriteCubit favouriteCubit =
              context.read<FavouriteCubit>();
    
          bool isFavourite = favouriteCubit.allFavouritesList.any(
            (isFavourite) =>
                isFavourite.docRef == productItem.docRef,
          );
    
          return Padding(
            padding: padding??EdgeInsets.only(right: 6) ,
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (!isFavourite) {
                  favouriteCubit.addToFavourite(
                      favouriteItem: FavouriteModel(
                    featureType: featureType,
                    docRef: productItem.docRef,
                  ));
                } else {
                  FavouriteModel favouriteItemDetails =
                      favouriteCubit.allFavouritesList.firstWhere(
                    (isFavourite) =>
                        isFavourite.docRef == productItem.docRef,
                  );
    
                  favouriteCubit.removeFromFavourite(
                      favItemDocRef:
                          favouriteItemDetails.FavouritedocRef!);
                }
              },
              child: isFavourite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: iconSize ?? 24,
                    )
                  : Icon(Icons.favorite_border,size: iconSize ?? 24,),
            ),
          );
        },
      ),
    );
  }
}
