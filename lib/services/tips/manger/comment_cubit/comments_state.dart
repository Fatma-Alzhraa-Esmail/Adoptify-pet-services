part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class FormFillStateState extends CommentsState {
  final bool formEmpty;

  FormFillStateState({required this.formEmpty});
}

final class AddCommentSucessState extends CommentsState {
  final CommentModel commentItem;

  AddCommentSucessState({required this.commentItem});
}

final class AddCommentFailureState extends CommentsState {
  final String errMessage;

  AddCommentFailureState({required this.errMessage});
}

final class FetchAllCommentsLoadedState extends CommentsState {
  final List<CommentModel> allComments;

  FetchAllCommentsLoadedState({required this.allComments});
}
final class FetchAllCommentsLoadingState extends CommentsState {

}
final class FetchAllCommentsFailureState extends CommentsState {
  final String errMessage;

  FetchAllCommentsFailureState({required this.errMessage});
}

final class FetchAllRepliesLoadedState extends CommentsState {
  final List<CommentModel> allComments;

  FetchAllRepliesLoadedState({required this.allComments});
}
final class FetchAllRepliesLoadingState extends CommentsState {

}
final class FetchAllRepliesFailureState extends CommentsState {
  final String errMessage;

  FetchAllRepliesFailureState({required this.errMessage});
}
final class IsReplyState extends CommentsState {

}
final class ReplyVisibilityChangedState extends CommentsState {

}