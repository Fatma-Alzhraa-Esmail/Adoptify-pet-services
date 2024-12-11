import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/home/repo/home_repo.dart';

part 'hot_shop_state.dart';

class HotShopCubit extends Cubit<HotShopState> {
  HotShopCubit(this.homeRepo) : super(HotShopInitial());
  final HomeRepo homeRepo;
  bool hotShopproductsLoading = true;
  List<ProductModel> hotShopList = [];

  Future<void> fetchHotShopProducts({required String mainFeatureId}) async {
    hotShopproductsLoading = true;
    emit(HotShopStateLoading());
    var productsList =
        await homeRepo.fetchPopularProducts(mainFeatureId: mainFeatureId);
    productsList.fold((failure) {
      emit(HotShopStateError(failure.errMessage));
       hotShopproductsLoading = true;
    }, (ToServicesList) {
      hotShopList = ToServicesList;
      emit(HotShopStateLoaded(ToServicesList));
       hotShopproductsLoading = false;
    });
  }

}
