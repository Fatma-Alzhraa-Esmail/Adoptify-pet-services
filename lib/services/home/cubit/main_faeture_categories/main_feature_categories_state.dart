part of 'main_feature_categories_cubit.dart';

@immutable
sealed class MainFeatureCategoriesState {}

final class MainFeatureCategoriesInitial extends MainFeatureCategoriesState {}

class MainFeaturesCategoriesLoading extends MainFeatureCategoriesState {}

class MainFeaturesCategoriesLoaded extends MainFeatureCategoriesState {
  final List<MainFeatureCategoriesModel> features;

  MainFeaturesCategoriesLoaded(this.features);
}

class MainFeaturesCategoriesError extends MainFeatureCategoriesState {
  final String error;

  MainFeaturesCategoriesError(this.error);
}

//////
class MainFeaturesCategoriesAllProductsLoading
    extends MainFeatureCategoriesState {}

class MainFeaturesCategoriesAllProductsLoaded
    extends MainFeatureCategoriesState {
  final List<MainFeatureCategoriesModel> products;
  final String selectedSubCategory;

  MainFeaturesCategoriesAllProductsLoaded(this.products,this.selectedSubCategory);
}

class MainFeaturesCategoriesAllProductsError
    extends MainFeatureCategoriesState {
  final String error;

  MainFeaturesCategoriesAllProductsError(this.error);
}
//////
class MainFeaturesCategoriesSpecificProductsLoading
    extends MainFeatureCategoriesState {}

class MainFeaturesCategoriesSpecificProductsLoaded
    extends MainFeatureCategoriesState {
  final List<ProductModel> products;

  MainFeaturesCategoriesSpecificProductsLoaded(this.products,);
}

class MainFeaturesCategoriesSpecificProductsError
    extends MainFeatureCategoriesState {
  final String error;

  MainFeaturesCategoriesSpecificProductsError(this.error);
}
class MainFeaturesChangeSelectedCategory extends MainFeatureCategoriesState {
  final String id;

  MainFeaturesChangeSelectedCategory(this.id);
}