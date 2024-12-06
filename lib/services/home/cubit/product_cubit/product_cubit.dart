import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  bool topServiceproductsLoading = true;
  bool hotShopproductsLoading = true;
  final _firestore = FirebaseFirestore.instance;
  List<ProductModel> topServicesProductsList= [];
  List<ProductModel> hotShopList = [];



  Future<void> fetchAllProducts({required String mainFeatureId}) async {
  topServiceproductsLoading = true;
  emit(ProductsLoading());
  print("Fetching all products for main feature ID: $mainFeatureId");

  try {
    // Step 1: Fetch all categories under the specific MainFeature
    final categoriesSnapshot = await _firestore
        .collection('MainFeatures')
        .doc(mainFeatureId)
        .collection('MainFeaturesCategories')
        .get();

    if (categoriesSnapshot.docs.isEmpty) {
      print("No categories found for main feature ID: $mainFeatureId");
      emit(ProductsError("No categories found."));
      return;
    }

    List<ProductModel> allProducts = [];

    // Step 2: Iterate through each category and fetch products
    for (var categoryDoc in categoriesSnapshot.docs) {
      final categoryId = categoryDoc.id;
      print("Fetching products for category ID: $categoryId");

      final productsSnapshot = await _firestore
          .collection('MainFeatures')
          .doc(mainFeatureId)
          .collection('MainFeaturesCategories')
          .doc(categoryId)
          .collection('Products')
           .where('rating.rate_count', isGreaterThan: 0)
          .orderBy('rating.rate_count',descending: false)
          .get();

      // Add products from this category to the allProducts list
      final products = productsSnapshot.docs.map((productDoc) {
        print("Product Data: ${productDoc.data()}");
        return ProductModel.fromJson(productDoc.data());
      }).toList();

      allProducts.addAll(products);
    }

    if (allProducts.isEmpty) {
      print("No products found across categories for main feature ID: $mainFeatureId");
      emit(ProductsError("No products found."));
      return;
    }

    print('All Parsed Products: $allProducts');
    emit(ProductsLoaded(allProducts));
    topServiceproductsLoading = false;
  } catch (e) {
    print("Error fetching products44: $e");
    emit(ProductsError(e.toString()));
  }
}

}
