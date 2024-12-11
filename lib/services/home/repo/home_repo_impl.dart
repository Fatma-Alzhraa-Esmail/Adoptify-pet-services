import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/home/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<ProductModel>>> fetchDealOfDayProducts() async{
    try {
    // Step 1: Fetch all MainFeatures
    final mainFeaturesSnapshot = await _firestore.collection('MainFeatures').get();

    if (mainFeaturesSnapshot.docs.isEmpty) {
      print("No MainFeatures found");
      return left(
          FirebaseFailure("No products found."),
        );
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
       return left(
          FirebaseFailure("No discounted products found."),
        );
    
    }
    print('All Discounted Products: $discountedProducts');
        return right(discountedProducts);

  } catch (e) {
    print("Error fetching discounted products: $e");
    print("Error fetching products44: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
  }
  }


  @override
  Future<Either<Failure, List<MainFeaturesModel>>> fetchMainFeatures() async {
    try {
      final querySnapshot = await _firestore
          .collection('MainFeatures')
          .orderBy('created_at', descending: false)
          .get();

      final features = querySnapshot.docs.map((doc) {
        return MainFeaturesModel.fromJson(doc.data());
      }).toList();

      print('//$features');
      return right(features);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchPopularProducts(
      {required String mainFeatureId}) async {
    try {
      // Step 1: Fetch all categories under the specific MainFeature
      final categoriesSnapshot = await _firestore
          .collection('MainFeatures')
          .doc(mainFeatureId)
          .collection('MainFeaturesCategories')
          .get();

      if (categoriesSnapshot.docs.isEmpty) {
        return left(
          FirebaseFailure("No products found."),
        );
      }
      List<ProductModel> allProducts = [];
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
            .orderBy('rating.rate_count', descending: false)
            .get();
        // Add products from this category to the allProducts list
        final products = productsSnapshot.docs.map((productDoc) {
          print("Product Data: ${productDoc.data()}");
          return ProductModel.fromJson(productDoc.data());
        }).toList();
        allProducts.addAll(products);
      }
      if (allProducts.isEmpty) {
        print(
            "No products found across categories for main feature ID: $mainFeatureId");

        return left(
          FirebaseFailure("No products found."),
        );
      }
      print('All Parsed Products: $allProducts');
      return right(allProducts);
    } catch (e) {
      print("Error fetching products44: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
