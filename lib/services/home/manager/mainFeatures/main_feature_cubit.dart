import 'package:bloc/bloc.dart';
import 'package:peto_care/services/home/manager/mainFeatures/main_feature_state.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';
import 'package:peto_care/services/home/repo/home_repo.dart';

class MainFeatureCubit extends Cubit<MainFeatureState> {
  MainFeatureCubit(this.homeRepo) : super(MainFeatureInitial());
  List<MainFeaturesModel> mainFeatures = [];
  String selectedMainFeatureCategory = "";
  bool categoriesLoading = true;
  final HomeRepo homeRepo;
  Future<void> selectCurrentCategory({required String id}) async {
    selectedMainFeatureCategory = id;
    print("id $id");
    emit(MainFeaturesSelectCategory(id));
  }

  Future<void> fetchMainFeatures() async {
    categoriesLoading = true;
    emit(MainFeaturesLoading());
    var result = await homeRepo.fetchMainFeatures();
    result.fold((failure) {
      emit(MainFeaturesError(failure.errMessage));
      categoriesLoading = true;
    }, (mainFeatureList) {
      mainFeatures = mainFeatureList;
      emit(MainFeaturesLoaded(mainFeatureList));
      categoriesLoading = false;
    });
  }
}
