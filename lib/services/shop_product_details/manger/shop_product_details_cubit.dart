import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo.dart';

class ShopProductDetailsCubit extends Cubit<ShopProductDetailsStates> {
  ShopProductDetailsCubit(this.productDetailsRepo)
      : super(ShopProductDetailsIntialStates());
  ProductDetailsRepo productDetailsRepo;
  static ShopProductDetailsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int currentImageListIndex = 0;
  String selectedColor = "";
  ProductModel? productItem;
  void changeColor(int index) {
    currentIndex = index;
    emit(ShopChangeImageIndexState(index: index));
  }

  void selectColor(String color, int colorImageListIndex) {
    selectedColor = color;
    currentImageListIndex = colorImageListIndex;
    emit(ShopChangeColor(
        color: color, colorImageListIndex: colorImageListIndex));
  }

  Future<void> updateTotalRate(
      {required ProductModel productItem, required num rate}) async {
    var updateTotalProductRate = await productDetailsRepo.updateTotalRate(
        rate: rate, productItem: productItem);
    updateTotalProductRate.fold((failure) {
      emit(ProductRateChangeErrorState(errMessage: failure.errMessage));
    }, (updatedProductModel) {
      emit(ProductRateChangeSuccessState(
          updatedProductItem: updatedProductModel));
    });
  }

  Future<ProductModel?> fetchProductDetails({
    required DocumentReference productRef,
  }) async {
    var productDetails =
        await productDetailsRepo.fetchProductDetails(productRef: productRef);
    productDetails.fold((failure) {
      emit(ProductDetailsError(errorMessage: failure.errMessage));
    }, (productDetails) {
      emit(ProductDetailsLoaded(productItem: productDetails));
    });
  }
}
