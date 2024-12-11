import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/home/repo/home_repo.dart';

part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit(this.homeRepo) : super(DiscountInitial());
  final HomeRepo homeRepo;
  bool discountLoading = true;
  List<ProductModel> discountList = [];

  Future<void> fetchAllDiscountedProducts() async {
    discountLoading = true;
    emit(DiscountProductsLoading());
    var discountProductsList =
        await homeRepo.fetchDealOfDayProducts();
    discountProductsList.fold((failure) {
      emit(DiscountProductsError(failure.errMessage));
      discountLoading = true;
    }, (DiscountList) {
      discountList = DiscountList;
      emit(DiscountProductsLoaded(DiscountList));
      discountLoading = false;
    });
  }
}
