import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/main_feature_categories_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';

part 'main_feature_categories_state.dart';

class MainFeatureCategoriesCubit extends Cubit<MainFeatureCategoriesState> {
  MainFeatureCategoriesCubit() : super(MainFeatureCategoriesInitial());
  List<MainFeatureCategoriesModel> mainFeaturesCategoriesList = [];
  String selectedCategory = "";
  List<ProductModel> products = [];
  bool subCategoriesLoading = true;
  bool productsLoading = true;
  Future<void> changeCurrentCategory({required String id}) async {
    selectedCategory = id;
    print("id $id");
    emit(MainFeaturesChangeSelectedCategory(id));
  }

  final _firestore = FirebaseFirestore.instance;
  Future<void> fetchMainFeatures({required String id}) async {
    subCategoriesLoading = true;
    emit(MainFeaturesCategoriesLoading());
    print("////id: $id");
    try {
      final querySnapshot = await _firestore
          .collection('MainFeatures')
          .doc(id)
          .collection('MainFeaturesCategories')
          .orderBy('created_at', descending: false)
          .get();

      final features = querySnapshot.docs.map((doc) {
        return MainFeatureCategoriesModel.fromJson(doc.data());
      }).toList();
      print('//$features');

      emit(MainFeaturesCategoriesLoaded(features));
      subCategoriesLoading = false;
    } catch (e) {
      emit(MainFeaturesCategoriesError(e.toString()));
    }
  }

  Future<void> fetchMainFeaturesCategoryAllProducts(
      {required String id}) async {
    // subCategoriesLoading = true;

    emit(MainFeaturesCategoriesAllProductsLoading());
    print("////id: $id");
    try {
      final querySnapshot = await _firestore
          .collection('MainFeatures')
          .doc(id)
          .collection('MainFeaturesCategories')
          .orderBy('created_at', descending: false)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No documents found in MainFeaturesCategories for id: $id");
        emit(MainFeaturesCategoriesAllProductsError("No documents found."));
        return;
      }

      final features = querySnapshot.docs.map((doc) {
        print("Document Data: ${doc.data()}");
        return MainFeatureCategoriesModel.fromJson(doc.data());
      }).toList();

      print('Parsed Features: $features');
      String selectedCategory = features.first.id;
      emit(MainFeaturesCategoriesAllProductsLoaded(features, selectedCategory));
      // subCategoriesLoading = false;
    } catch (e) {
      print("Error fetching documents here: $e");
      emit(MainFeaturesCategoriesAllProductsError(e.toString()));
    }
  }

  Future<void> fetchMainFeaturesProductsBasedCategory({
    required String mainFeature,
    required String mainFeatureCategory,
  }) async {
    productsLoading = true;
    emit(MainFeaturesCategoriesSpecificProductsLoading());
    print(
        "////mainFeature: $mainFeature  mainFeatureCategory: $mainFeatureCategory ");

    try {
      final querySnapshot = await _firestore
          .collection('MainFeatures')
          .doc(mainFeature)
          .collection('MainFeaturesCategories')
          .doc(mainFeatureCategory)
          .collection('Products')
          .orderBy('created_at', descending: true)
          .get();

      final products = querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
      print('products//$products');
      emit(MainFeaturesCategoriesSpecificProductsLoaded(products));
          productsLoading = false;

    } catch (e) {
      print("product error $e");
      emit(MainFeaturesCategoriesSpecificProductsError(e.toString()));
    }
  }

  Future<void> AllOperation({
    required id,
    categoryId,
  }) async {
        subCategoriesLoading = true;

    await fetchMainFeatures(id: id);
    await fetchMainFeaturesCategoryAllProducts(id: id);

    await fetchMainFeaturesProductsBasedCategory(
        mainFeature: id, mainFeatureCategory: categoryId ?? selectedCategory);
  }
}
