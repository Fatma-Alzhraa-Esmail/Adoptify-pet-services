import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/services/home/model/product_model.dart';

part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit() : super(DiscountInitial());
  
  bool discountLoading = true;
  final _firestore = FirebaseFirestore.instance;
  List<ProductModel> discountList = [];



Future<void> fetchAllDiscountedProducts() async {
  discountLoading = true;
  emit(DiscountProductsLoading());
  print("Fetching all discounted products across all MainFeatures");

  try {
    // Step 1: Fetch all MainFeatures
    final mainFeaturesSnapshot = await _firestore.collection('MainFeatures').get();

    if (mainFeaturesSnapshot.docs.isEmpty) {
      print("No MainFeatures found");
      emit(DiscountProductsError("No MainFeatures found."));
      return;
    }

    List<ProductModel> discountedProducts = [];

    // Step 2: Iterate through each MainFeature
    for (var mainFeatureDoc in mainFeaturesSnapshot.docs) {
      final mainFeatureId = mainFeatureDoc.id;
      print("Processing MainFeature ID: $mainFeatureId");

      // Step 3: Fetch all categories under this MainFeature
      final categoriesSnapshot = await _firestore
          .collection('MainFeatures')
          .doc(mainFeatureId)
          .collection('MainFeaturesCategories')
          .get();

      if (categoriesSnapshot.docs.isEmpty) {
        print("No categories found for MainFeature ID: $mainFeatureId");
        continue; // Skip this MainFeature if no categories are found
      }

      // Step 4: Iterate through each category and fetch products with discount != 0
      for (var categoryDoc in categoriesSnapshot.docs) {
        final categoryId = categoryDoc.id;
        print("Fetching discounted products for category ID: $categoryId in MainFeature ID: $mainFeatureId");

        final productsSnapshot = await _firestore
            .collection('MainFeatures')
            .doc(mainFeatureId)
            .collection('MainFeaturesCategories')
            .doc(categoryId)
            .collection('Products')
            .where('discount', isNotEqualTo: 0)
            .orderBy('discount', descending: true) // Optional: order by discount value
            .get();

        // Add discounted products from this category to the discountedProducts list
        final products = productsSnapshot.docs.map((productDoc) {
          print("Discounted Product Data: ${productDoc.data()}");
          return ProductModel.fromJson(productDoc.data());
        }).toList();

        discountedProducts.addAll(products);
      }
    }

    if (discountedProducts.isEmpty) {
      print("No discounted products found across all MainFeatures");
      emit(DiscountProductsError("No discounted products found."));
      return;
    }

    print('All Discounted Products: $discountedProducts');
    emit(DiscountProductsLoaded(discountedProducts));
    discountLoading = false;
  } catch (e) {
    print("Error fetching discounted products: $e");
    emit(DiscountProductsError(e.toString()));
  }
}

}
