import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/repo/product_details_repo.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo {

  @override
  Future<Either<Failure, ProductModel>> updateTotalRate(
      {required num rate, required ProductModel productItem}) async {
    try {
      num new_rate_count = productItem.rating!.rate_count! + 1;
      num new_rate =
          (productItem.rating!.rate! * productItem.rating!.rate_count! + rate) /
              new_rate_count;

      final data = {
        'rating.rate': double.parse(new_rate.toStringAsFixed(2)),
        'rating.rate_count': new_rate_count,
      };
      final productUpdate = await productItem.docRef.update(data);
      return right(productItem);
    } catch (e) {
      print("Error fetching discounted products: $e");
      print("Error fetching products44: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }


}
