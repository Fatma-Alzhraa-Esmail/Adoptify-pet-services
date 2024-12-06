import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto_care/services/home/cubit/mainFeatures/main_feature_state.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';

class MainFeatureCubit extends Cubit<MainFeatureState> {
  MainFeatureCubit() : super(MainFeatureInitial());
  List<MainFeaturesModel> mainFeaturesList = [];
  String selectedMainFeatureCategory = "";
    bool categoriesLoading = true;

 Future<void> selectCurrentCategory({required String id}) async{
    selectedMainFeatureCategory = id;
    print("id $id");
    emit(MainFeaturesSelectCategory(id));
  }

  final _firestore = FirebaseFirestore.instance;
  Future<void> fetchMainFeatures() async {
     categoriesLoading = true;

    emit(MainFeaturesLoading());

    try {
      final querySnapshot = await _firestore
          .collection('MainFeatures')
          .orderBy('created_at', descending: false)
          .get();

      final features = querySnapshot.docs.map((doc) {
        return MainFeaturesModel.fromJson(doc.data());
      }).toList();
      
      print('//$features');
      categoriesLoading = false;
      emit(MainFeaturesLoaded(features));
        
    } catch (e) {
      emit(MainFeaturesError(e.toString()));
    }
  }
}
