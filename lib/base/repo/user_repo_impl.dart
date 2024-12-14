import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/base/repo/user_repo.dart';
import 'package:peto_care/core/errors/failure.dart';

class UserRepoImpl implements UserRepo {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserModel>> fetchUserData(
      {required String userId}) async {
    try {
      var userSnapShot = await _firestore.collection("users").doc(userId).get();
      UserModel userData = UserModel.fromJson(userSnapShot.data()!);
      return right(userData);
    } catch (e) {
      print("Error Get reviewsList: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
