import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/base/manger/user/user_cubit.dart';
import 'package:peto_care/base/repo/user_repo_impl.dart';
import 'package:peto_care/services/shop_product_details/manger/reivew_cubit/reviews_cubit.dart';
import 'package:peto_care/utilities/components/rating_widget.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../home/model/product_model.dart';

class TopReviewsBody extends StatelessWidget {
  const TopReviewsBody({
    super.key,
    required this.productItem,
  });
  final ProductModel productItem;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listener: (context, state) {
        ReviewsCubit reviewsCubitInstance = context.read<ReviewsCubit>();
        if (state is ReviewsLoadingState) {
        } else if (state is ReviewsLoadedState) {
          reviewsCubitInstance.ReviewsList = state.reviewsList;
        } else if (state is SelectedImagesState) {
          reviewsCubitInstance.images = state.images;
        } else if (state is ReviewsLoadedState) {
          reviewsCubitInstance.ReviewsList = state.reviewsList;
        } else if (state is AskToEditReviewState) {}
      },
      builder: (context, state) {
        ReviewsCubit reviewsCubitInstance = context.read<ReviewsCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: reviewsCubitInstance.ReviewsList.length != 0
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top reviews",
                          style: AppTextStyles.w600.copyWith(fontSize: 20),
                        ),
                        Text(
                          "See All",
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 16, color: LightTheme().mainColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: reviewsCubitInstance.ReviewsList.length > 3
                          ? 3
                          : reviewsCubitInstance.ReviewsList.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 14,
                      ),
                      itemBuilder: (context, index) {
                        var reviewItemIndex =
                            reviewsCubitInstance.ReviewsList[index];
                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocProvider(
                                      create: (context) =>
                                          UserCubit(UserRepoImpl())
                                            ..fetchUserData(
                                                userId:
                                                    reviewItemIndex.user_id),
                                      child: BlocBuilder<UserCubit, UserState>(
                                        builder: (context, state) {
                                          UserCubit userCubitInstance =
                                              context.read<UserCubit>();
                                          if (state is UserLoaded) {
                                            return Row(
                                              children: [
                                                CircleAvatar(
                                                  foregroundImage:
                                                      state.userData.image == ""
                                                          ? NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/test-project-42c06.appspot.com/o/user.jpeg?alt=media&token=c8fb2e3f-24b1-40bf-98a5-93872f9b37f7',
                                                            )
                                                          : NetworkImage(
                                                              state.userData
                                                                      .image ??
                                                                  'https://firebasestorage.googleapis.com/v0/b/test-project-42c06.appspot.com/o/user.jpeg?alt=media&token=c8fb2e3f-24b1-40bf-98a5-93872f9b37f7',
                                                            ),
                                                  radius: 24,
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.userData?.name ??
                                                          "",
                                                      style: AppTextStyles.w600,
                                                    ),
                                                    Text(
                                                      reviewItemIndex
                                                                  .created_at !=
                                                              null
                                                          ? timeago.format(
                                                              reviewItemIndex
                                                                  .created_at!)
                                                          : "No date available",
                                                      style: AppTextStyles.w600
                                                          .copyWith(
                                                        fontSize: 14,
                                                        color: LightTheme()
                                                            .borderColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ),
                                    RatingsWidget(
                                      iconSize: 14,
                                      paddingBetweenIcons: 0.7,
                                      unratedColor: LightTheme().borderColor,
                                      rate: reviewItemIndex.user_rate as double,
                                      onDateSelected: (rate) async {
                                        return rate;
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 56),
                                  child: Text(
                                    reviewItemIndex.comment ?? "",
                                    style: AppTextStyles.w400,
                                  ),
                                ),
                                reviewItemIndex.images?.isNotEmpty ?? false
                                    ? SizedBox(
                                        height:
                                            90, // Constraint ListView's height
                                        child: ListView.separated(
                                          shrinkWrap: false,
                                          padding: const EdgeInsets.only(
                                              left: 56, top: 16),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, imageIndex) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              height: 60,
                                              width: 70,
                                              reviewItemIndex
                                                  .images![imageIndex],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(width: 8),
                                          itemCount:
                                              reviewItemIndex.images?.length ??
                                                  0,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            reviewsCubitInstance.ReviewsList.length > 3 &&
                                    index != 2
                                ? Divider(
                                    color: LightTheme()
                                        .borderColor
                                        .withOpacity(0.4),
                                    height: 0.5,
                                    thickness: 1,
                                  )
                                : Container(),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Container(),
        );
      },
    );
  }
}
