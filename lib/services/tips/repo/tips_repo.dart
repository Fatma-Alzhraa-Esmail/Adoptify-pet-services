import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';

abstract class TipsRepo {
  Future<Either<Failure, List<TipsModel>>> getStatusTips();
  Future<Either<Failure, List<TipsModel>>> getHighlightedTips();
  Future<Either<Failure, List<TipsModel>>> getTips();
}
