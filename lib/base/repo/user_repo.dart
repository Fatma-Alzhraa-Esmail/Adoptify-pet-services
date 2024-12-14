import 'package:dartz/dartz.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/core/errors/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> fetchUserData({required String userId});
}
