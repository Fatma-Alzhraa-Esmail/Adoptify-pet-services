import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/tips/model/comment_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/repo/comments_repo/comment_repo.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit(this.commentRepo) : super(CommentsInitial());
  /////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////// Variables
  /////////////////////////////////////////////////////////////////
  TextEditingController commentController = TextEditingController();
  bool isCommentEmpty = true;
  final CommentRepo commentRepo;
  List<CommentModel> allComments = [];
  List<CommentModel> allReplies = [];
  DocumentReference? repliedOn;
  String metionedName = '';
  final _firebaseFirestore = FirebaseFirestore.instance;
  CommentModel? main_comment;
  String mentioned = "";
  bool is_reply = false;

    var userid = SharedHandler.instance!
                                          .getData(
                                              key: SharedKeys().user,
                                              valueType: ValueType.string);
  bool isEmpty() {
    var formIsEmpty = commentController.text.isEmpty;
    isCommentEmpty = formIsEmpty;
    print(formIsEmpty);
    emit(FormFillStateState(formEmpty: formIsEmpty));

    return formIsEmpty;
  }

  Future<CommentModel?> addComment(
      {required CommentModel commentItem,
      required bool isRepliy,
      required TipsModel tipItem,
      CommentModel? parentCommentRef}) async {
    var addComment = await commentRepo.addComment(
      parentComment: main_comment,
      commentItem: commentItem,
      isRepliy: is_reply,
      tipDoc: tipItem.docRef,
    );
    addComment.fold(
      (failure) {
        emit(AddCommentFailureState(errMessage: failure.errMessage));
      },
      (commentItem) {
        emit(AddCommentSucessState(commentItem: commentItem));
        commentController.clear();
        isEmpty();
        fetchAllComments(tipItem: tipItem);
        main_comment = null;
        is_reply = false;
        mentioned = "";
        metionedName = "";
        repliedOn = null;
      },
    );
  }

Future<List<CommentModel>?> fetchAllComments({
  required TipsModel tipItem,
}) async {
  var fetchComments = await commentRepo.getAllComments(tipDoc: tipItem.docRef);

  fetchComments.fold(
    (failure) {
      emit(FetchAllCommentsFailureState(errMessage: failure.errMessage));
    },
    (comments) {
      allComments = comments;

      // Initialize visibleRepliesCount for each comment
      for (var comment in comments) {
        initializeRepliesCount(comment.comment_id!.id, 1);
      }

      emit(FetchAllCommentsLoadedState(allComments: comments));
    },
  );
}

Future<List<CommentModel>?> fetchReplies({
  required TipsModel tipItem,
  required DocumentReference commentId,
}) async {
  // Get the current visible count for the replies
  int visibleCount = visibleRepliesCount[commentId.id] ?? 1;

  // Fetch replies from the repository
  var fetchReplies = await commentRepo.getReplies(
    commentId: commentId,
    tipDoc: tipItem.docRef,
  );

  fetchReplies.fold(
    (failure) {
      emit(FetchAllRepliesFailureState(errMessage: failure.errMessage));
    },
    (replies) {
      // Limit the replies to the visible count
      allReplies = replies.take(visibleCount).toList();
      emit(FetchAllRepliesLoadedState(allComments: allReplies));
    },
  );
}

  isReply(DocumentReference userRef, CommentModel mainComment) async {
    repliedOn = userRef;
    var userSnapshot =
        await _firebaseFirestore.collection('users').doc(userRef.id).get();
    UserModel userMentioned = UserModel.fromJson(userSnapshot.data()!);
    metionedName = userMentioned.name ?? "";
    mentioned = "@$metionedName  ";
    commentController.text = mentioned;
    main_comment = mainComment;
    is_reply = true;
    emit(IsReplyState());
    isEmpty();
  }

    Future<void> addRemoveLike(
      {required CommentModel commentItem,
      required TipsModel tipItem,
      CommentModel? parentCommentRef}) async {
    var addComment = await commentRepo.addLike(
    
      commentItem: commentItem,
      tipDoc: tipItem.docRef,
    );
    addComment.fold(
      (failure) {
        
      },
      (likeSuccesss) {
        fetchAllComments(tipItem: tipItem);
       
      },
    );
  }


 Map<String, int> visibleRepliesCount = {};

  void initializeRepliesCount(String commentId, int initialCount) {
    if (!visibleRepliesCount.containsKey(commentId)) {
      visibleRepliesCount[commentId] = initialCount;
    }
  }


void showMoreReplies(String commentId, int additionalCount, TipsModel tipItem) {
  if (visibleRepliesCount.containsKey(commentId)) {
    visibleRepliesCount[commentId] =
        visibleRepliesCount[commentId]! + additionalCount;
  } else {
    visibleRepliesCount[commentId] = additionalCount;
  }

  emit(FetchAllCommentsLoadedState(allComments: allComments)); // Trigger UI update
}



}
