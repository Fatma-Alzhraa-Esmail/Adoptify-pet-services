import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/home/model/product_model.dart';

abstract class ProductDetailsRepo {
  Future<Either<Failure, ProductModel>> updateTotalRate(
      {required num rate, required ProductModel productItem});
 Future<Either<Failure,ProductModel>> fetchProductDetails({required DocumentReference productRef});
}
