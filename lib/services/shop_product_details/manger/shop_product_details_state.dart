import 'package:peto_care/services/home/model/product_model.dart';

abstract class ShopProductDetailsStates {}

class ShopProductDetailsIntialStates extends ShopProductDetailsStates {}

class ShopProductDetailsLoading extends ShopProductDetailsStates {}

class ShopProductDetailsLoaded extends ShopProductDetailsStates {}

class ShopProductDetailsError extends ShopProductDetailsStates {
  final String errorMessage;

  ShopProductDetailsError({required this.errorMessage});
}

class ShopChangeImageIndexState extends ShopProductDetailsStates {
  final int index;

  ShopChangeImageIndexState({required this.index});
}

class ShopChangeColor extends ShopProductDetailsStates {
  final String color;
  final int colorImageListIndex;

  ShopChangeColor({required this.color, required this.colorImageListIndex});
}
// reviw

class ProductRateChangeErrorState extends ShopProductDetailsStates {
  final String errMessage;

  ProductRateChangeErrorState({required this.errMessage});
}

class ProductRateChangeSuccessState extends ShopProductDetailsStates {
  final ProductModel updatedProductItem;

  ProductRateChangeSuccessState({required this.updatedProductItem});
}

class ProductDetailsLoading extends ShopProductDetailsStates {}

class ProductDetailsLoaded extends ShopProductDetailsStates {
final  ProductModel productItem;

  ProductDetailsLoaded({required this.productItem});

}

class ProductDetailsError extends ShopProductDetailsStates {
  final String errorMessage;

  ProductDetailsError({required this.errorMessage});
}
