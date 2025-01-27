import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/base/manger/user/user_cubit.dart';
import 'package:peto_care/base/repo/user_repo_impl.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/services/tips/manger/comment_cubit/comments_cubit.dart';
import 'package:peto_care/services/tips/model/comment_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/repo/comments_repo/comment_repo_imp.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, required this.tipsItem});
  final TipsModel tipsItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => CustomNavigator.pop(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: LightTheme().secondery,
          ),
        ),
        titleTextStyle: AppTextStyles.w800.copyWith(fontSize: 20),
        title: Text('Comments'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CommentsCubit(CommentRepoImp())
          ..fetchAllComments(tipItem: tipsItem),
        child: BlocConsumer<CommentsCubit, CommentsState>(
          listener: (context, state) {
            CommentsCubit commentCubit = context.read<CommentsCubit>();
            if (state is FormFillStateState) {
              commentCubit.isCommentEmpty = state.formEmpty;
            } else if (state is FetchAllCommentsLoadedState) {
              commentCubit.allComments = state.allComments;
            } else if (state is IsReplyState) {
            } else if (state is ReplyVisibilityChangedState) {}
          },
          builder: (context, state) {
            CommentsCubit commentCubit = context.read<CommentsCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  // Expanded Comment List
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          commentCubit.allComments.length,
                          (index) => Column(
                            children: [
                              !commentCubit.allComments[index].is_repliy
                                  ? _buildComment(
                                      context,
                                      commentItem:
                                          commentCubit.allComments[index],
                                      mainComment:
                                          commentCubit.allComments[index],
                                      isReply: false,
                                      commentCubit: commentCubit,
                                    )
                                  : Container(),
                              !commentCubit.allComments[index].is_repliy
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 20),
                                      child: Divider(
                                        color: LightTheme()
                                            .greyTitle
                                            .withOpacity(0.3),
                                        height: 1,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Comment Input Field at Bottom
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextInputField(
                              withBottomPadding: true,
                              borderType: BorderType.Outline,
                              controller: commentCubit.commentController,
                              hintText: 'Add a comment',
                              minLines: 1,
                              maxLines: 4,
                              onChange: (p0) {
                                commentCubit.isEmpty();
                              },
                            ),
                          ),
                          if (!commentCubit.isCommentEmpty)
                            GestureDetector(
                              onTap: () {
                                commentCubit.addComment(
                                  commentItem: CommentModel(
                                    comment_content: commentCubit.is_reply
                                        ? commentCubit.commentController.text
                                            .replaceAll(
                                                commentCubit.mentioned, "")
                                            .trim()
                                        : commentCubit.commentController.text,
                                    likes_count: 0,
                                    likes_accounts: [],
                                    created_at: DateTime.now(),
                                    is_repliy: commentCubit.is_reply,
                                    repliedOn: commentCubit.repliedOn,
                                  ),
                                  isRepliy: commentCubit.is_reply,
                                  tipItem: tipsItem,
                                  parentCommentRef: commentCubit.main_comment,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Icon(
                                  Icons.send_rounded,
                                  color: LightTheme().mainColor,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build a Comment with Nested Replies
  Widget _buildComment(
    BuildContext context, {
    bool isReply = false,
    required CommentModel mainComment,
    required CommentModel commentItem,
    required CommentsCubit commentCubit,
  }) {
    return BlocProvider(
      create: (context) => UserCubit(UserRepoImpl())
        ..fetchUserData(userId: commentItem.user!.id),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 16.0,
          left: isReply ? 40.0 : 0.0, // Indent replies
        ),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
           
            int visibleReplies =
                commentCubit.visibleRepliesCount[mainComment.comment_id!.id] ??
                    1;

            // Initialize visible replies for each comment
            commentCubit.initializeRepliesCount(mainComment.comment_id!.id, 1);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Comment content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: state is UserLoaded
                          ? state.userData.image!.isEmpty ||
                                  state.userData.image!.isEmpty
                              ? AssetImage(Assets.assetsImagesPerson)
                              : NetworkImage(state.userData.image!)
                          : AssetImage(Assets.assetsImagesPerson),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state is UserLoaded
                                ? state.userData.name ?? ""
                                : "",
                            style: AppTextStyles.w400.copyWith(fontSize: 18),
                          ),
                          Text(
                            timeago.format(commentItem.created_at),
                            style: AppTextStyles.w500.copyWith(
                              fontSize: 13,
                              color: LightTheme().greyTitle,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            commentItem.comment_content,
                            style: AppTextStyles.w600.copyWith(
                              fontSize: 15,
                              color: LightTheme().greyTitle,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              // Like button and count
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      commentCubit.addRemoveLike(
                                        commentItem: commentItem,
                                        tipItem: tipsItem,
                                      );
                                    },
                                    child: Icon(
                                      commentItem.likes_accounts
                                              .map((e) => e.id)
                                              .contains(commentCubit.userid)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: commentItem.likes_accounts
                                              .map((e) => e.id)
                                              .contains(commentCubit.userid)
                                          ? Colors.red
                                          : LightTheme()
                                              .secondery
                                              .withOpacity(0.8),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    commentItem.likes_count.toString(),
                                    style: AppTextStyles.w600.copyWith(
                                      fontSize: 16,
                                      color: LightTheme()
                                          .secondery
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 50),
                              GestureDetector(
                                onTap: () {
                                  commentCubit.repliedOn = commentItem.user;
                                  commentCubit.isReply(
                                      commentItem.user!, mainComment);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.reply,
                                      size: 20,
                                      color: LightTheme()
                                          .secondery
                                          .withOpacity(0.8),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Reply",
                                      style: AppTextStyles.w600.copyWith(
                                        fontSize: 16,
                                        color: LightTheme()
                                            .secondery
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Render Replies
                if (commentItem.replies!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      children: [
                        ...commentItem.replies!
                            .take(visibleReplies)
                            .map((reply) => _buildComment(
                                  mainComment: mainComment,
                                  commentCubit: commentCubit,
                                  context,
                                  commentItem: reply,
                                  isReply: reply.is_repliy,
                                ))
                            .toList(),
                        if (commentItem.replies!.length > visibleReplies)
                          GestureDetector(
                            onTap: () {
                              commentCubit.showMoreReplies(
                                  mainComment.comment_id!.id, 3, tipsItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Show more replies",
                                style: AppTextStyles.w500.copyWith(
                                  fontSize: 14,
                                  color: LightTheme().mainColor,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
