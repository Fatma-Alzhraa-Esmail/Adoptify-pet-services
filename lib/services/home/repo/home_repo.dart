import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<MainFeaturesModel>>> fetchMainFeatures();
  Future<Either<Failure, List<ProductModel>>> fetchPopularProducts({required String mainFeatureId});
  Future<Either<Failure, List<ProductModel>>> fetchDealOfDayProducts();
}
