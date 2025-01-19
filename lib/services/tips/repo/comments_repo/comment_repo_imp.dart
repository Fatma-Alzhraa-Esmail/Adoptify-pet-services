import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/tips/model/comment_model.dart';
import 'package:peto_care/services/tips/repo/comments_repo/comment_repo.dart';

class CommentRepoImp implements CommentRepo {
  final _firebase = FirebaseFirestore.instance;
  String userId = SharedHandler.instance!
      .getData(key: SharedKeys().user, valueType: ValueType.string);
  @override
  Future<Either<Failure, CommentModel>> addComment({
    required DocumentReference tipDoc,
    required CommentModel commentItem,
    required bool isRepliy,
    CommentModel? parentComment,
    // Optional for replies
  }) async {
    print('''
$tipDoc
$commentItem
$isRepliy
$parentComment
''');
    try {
      // Fetch the user ID

      // Prepare comment data
      final commentData = CommentModel(
        comment_content: commentItem.comment_content,
        likes_count: commentItem.likes_count,
        likes_accounts: [],
        replies: [],
        created_at: DateTime.now(),
        is_repliy: isRepliy,
        user: _firebase.doc('Users/$userId'),
      ).toJson();

      // Add comment/reply to the same collection
      final commentsCollection = tipDoc.collection('Comments');
      final commentDocRef = await commentsCollection.add(commentData);

      // Update the document with its reference
      await commentDocRef.update({
        'comment_id': commentDocRef,
      });
      final parentCommentDocRef = parentComment?.comment_id;
      if (isRepliy && parentCommentDocRef != null) {
        print("isRepliy :$isRepliy");
        print("parentComment :$parentComment");
        // Update the parent comment's 'replies' field
        await commentDocRef.update({'repliedOn': parentComment?.user});
        await parentCommentDocRef.update({
          'replies': FieldValue.arrayUnion([commentDocRef])
        });
      } else {
        print("cannt add it");
      }

      // Return the newly created comment
      commentData['comment_id'] = commentDocRef;
      return Right(CommentModel.fromJson(commentData));
    } catch (e) {
      print("Error adding comment: $e");
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseError(e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getAllComments({
    required DocumentReference tipDoc,
  }) async {
    try {
      // Step 1: Fetch all comments
      final querySnapshot = await tipDoc
          .collection('Comments')
          .orderBy('created_at', descending: true)
          .get();

      final comments = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CommentModel.fromJson({
          ...data,
          'id': doc.id, // Include document ID if needed
        });
      }).toList();

      // Step 2: Fetch replies for each comment
      for (var comment in comments) {
        if (comment.replies != null && comment.replies!.isNotEmpty) {
          // Fetch replies by document reference
          final repliesSnapshot = await tipDoc
              .collection('Comments')
              .where(FieldPath.documentId,
                  whereIn: comment.replies!.map((ref) => ref.comment_id))
              .get();

          // Correctly map the Firestore data to a List<CommentModel>
          final replies = repliesSnapshot.docs.map((doc) {
            final replyData = doc.data();
            return CommentModel.fromJson({
              ...replyData,
              'id': doc.id,
            });
          }).toList();

          // Assign fetched replies to the comment's repliesList
          comment.replies = replies;
        }
      }

      return Right(comments);
    } catch (e) {
      print("Error fetching comments and replies: $e");

      if (e is FirebaseException) {
        return Left(
            FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getReplies({
    required DocumentReference tipDoc,
    required DocumentReference commentId,
  }) async {
    try {
      // Query the Firestore collection for comments that reference the given commentId
      final querySnapshot = await tipDoc
          .collection('Comments')
          .where('replies', arrayContains: commentId)
          .get();

      // Map the results to a list of CommentModel instances
      final comments = querySnapshot.docs
          .map((doc) => CommentModel.fromJson({
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id, // Include document ID for reference if needed
              }))
          .toList();

      // Return the list of comments wrapped in a Right (success)
      return Right(comments);
    } catch (e) {
      // Print the error for debugging purposes
      print("Error fetching comments: $e");

      // Handle Firebase-specific exceptions
      if (e is FirebaseException) {
        return Left(
            FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
      }

      // Return a general failure if the error is not Firebase-specific
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
Future<Either<Failure, void>> addLike({
  required DocumentReference<Object?> tipDoc,
  required CommentModel commentItem,
}) async {
  try {
    var commentRef = commentItem.comment_id;

    // Check if the document exists
    var docSnapshot = await commentRef;
    // if (!docSnapshot.exists) {
    //   print("Document does not exist: ${commentRef.path}");
    //   return Left(FirebaseFailure("Document does not exist"));
    // }

    // Construct the user's DocumentReference
    var userRef = _firebase.collection('users').doc(userId);

    // Check if the user's reference exists in likes_accounts
    if (!commentItem.likes_accounts.contains(userRef)) {
      // User has not liked the comment, add their reference
      await commentRef?.update({
        'likes_accounts': FieldValue.arrayUnion([userRef]),
        'likes_count': commentItem.likes_count + 1,
      });
    } else {
      // User has already liked the comment, remove their reference
      await commentRef?.update({
        'likes_accounts': FieldValue.arrayRemove([userRef]),
        'likes_count': commentItem.likes_count - 1,
      });
    }

    return Right(0);
  } catch (e) {
    // Print the error for debugging purposes
    print("Error updating likes: $e");

    // Handle Firebase-specific exceptions
    if (e is FirebaseException) {
      return Left(FirebaseFailure.fromFirebaseError(e.message ?? e.toString()));
    }

    // Return a general failure if the error is not Firebase-specific
    return Left(FirebaseFailure(e.toString()));
  }
}

}
