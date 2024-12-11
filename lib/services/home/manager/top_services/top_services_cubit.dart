import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/home/repo/home_repo.dart';
part 'top_services_state.dart';

class ProductCubit extends Cubit<TopServicesState> {
  ProductCubit(this.homeRepo) : super(TopServicesStateInitial());
  final HomeRepo homeRepo;

  bool topServiceproductsLoading = true;
  bool hotShopproductsLoading = true;
  List<ProductModel> topServicesProductsList = [];
  List<ProductModel> hotShopList = [];

  Future<void> fetchAllProducts({required String mainFeatureId}) async {
    topServiceproductsLoading = true;
    emit(TopServicesStatesLoading());
    var productsList =
        await homeRepo.fetchPopularProducts(mainFeatureId: mainFeatureId);
    productsList.fold((failure) {
      emit(TopServicesStatesError(failure.errMessage));
       topServiceproductsLoading = true;
    }, (ToServicesList) {
      hotShopList = ToServicesList;
      emit(TopServicesStatesLoaded(ToServicesList));
       topServiceproductsLoading = false;
    });
  }
}
