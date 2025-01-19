import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/tips/model/comment_model.dart';

abstract class CommentRepo {
  Future<Either<Failure, CommentModel>> addComment({
    required DocumentReference tipDoc,
    required CommentModel commentItem,
    required bool isRepliy,
    CommentModel? parentComment,
    });
  Future<Either<Failure, List<CommentModel>>> getAllComments({required DocumentReference tipDoc});
  Future<Either<Failure, List<CommentModel>>> getReplies({required DocumentReference tipDoc, required DocumentReference commentId});
 Future<Either<Failure, void>> addLike({required DocumentReference tipDoc, required CommentModel commentItem});

}