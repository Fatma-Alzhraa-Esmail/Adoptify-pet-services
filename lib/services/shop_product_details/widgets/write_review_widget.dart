import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/base/manger/user/user_cubit.dart';
import 'package:peto_care/base/repo/user_repo_impl.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/services/shop_product_details/manger/reivew_cubit/reviews_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_cubit.dart';
import 'package:peto_care/services/shop_product_details/manger/shop_product_details_state.dart';
import 'package:peto_care/services/shop_product_details/model/review_model.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';
import 'package:peto_care/utilities/components/rating_widget.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;
class WriteReviewWidget extends StatelessWidget {
  const WriteReviewWidget({super.key, required this.productDetails});
  final ProductModel productDetails;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listener: (context, state) {
        ReviewsCubit reviewsCubit = BlocProvider.of<ReviewsCubit>(context);
        if (state is SelectedImagesState) {
          reviewsCubit.images = state.images;
        } else if (state is ReviewsLoadedState) {
          reviewsCubit.ReviewsList = state.reviewsList;
        } else if (state is AskToEditReviewState) {}
        else if (state is ReviewAddSuccessfullyState) {}
      },
      builder: (context, state) {
        ReviewsCubit reviewsCubit = BlocProvider.of<ReviewsCubit>(context);
        final currentUserId = SharedHandler.instance!.getData(
            key: SharedKeys().user,
            valueType: ValueType
                .string); // Replace with actual logic to get the user's ID

        // Check if a review exists for the current user
        final hasUserReview = reviewsCubit.ReviewsList.any(
          (review) => review.user_id == currentUserId,
        );

        if (hasUserReview && reviewsCubit.isEdit == false) {
          ReviewModel? userReview = reviewsCubit.ReviewsList.firstWhere(
            (review) => review.user_id == currentUserId,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Expandable(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.8,
                    color: const Color.fromARGB(255, 179, 177, 177))
              ],
              firstChild: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider(
                        create: (context) => UserCubit(UserRepoImpl())
                          ..fetchUserData(userId: currentUserId),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                          
                            if (state is UserLoaded) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    foregroundImage: state.userData.image == ""
                                        ? NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/test-project-42c06.appspot.com/o/user.jpeg?alt=media&token=c8fb2e3f-24b1-40bf-98a5-93872f9b37f7',
                                          )
                                        : NetworkImage(
                                            state.userData.image ??
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.userData.name ?? "",
                                        style: AppTextStyles.w600,
                                      ),
                                      Text(
                                        userReview.created_at != null
                                            ? timeago
                                                .format(userReview.created_at!)
                                            : "No date available",
                                        style: AppTextStyles.w600.copyWith(
                                          fontSize: 14,
                                          color: LightTheme().borderColor,
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
                        rate: userReview.user_rate as double,
                        onDateSelected: (rate) async {
                          return rate;
                        },
                      )
                    ],
                  ),
                ),
              ),

              showArrowWidget: false,
              secondChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  userReview.comment!.isNotEmpty?  Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Text(
                        userReview.comment ?? "",
                        style: AppTextStyles.w400,
                      ),
                    ):Container(),
                    userReview.images?.isNotEmpty ?? false
                        ? SizedBox(
                            height: 90, // Constraint ListView's height
                            child: ListView.separated(
                              shrinkWrap: false,
                              padding: const EdgeInsets.only(left: 56, top: 16),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, imageIndex) => ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  height: 60,
                                  width: 70,
                                  userReview.images![imageIndex],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8),
                              itemCount: userReview.images?.length ?? 0,
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: CustomBtn(
                        onTap: () {
                          reviewsCubit.askToEditReview(
                              comment: userReview.comment ?? "",
                              currentRate: userReview.user_rate ?? 0.0);
                        },
                        text: Text(
                          "Edit Review",
                          style: AppTextStyles.w600
                              .copyWith(color: LightTheme().background),
                        ),
                        buttonColor: LightTheme().mainColor,
                        height: 44,
                      ),
                    )
                  ],
                ),
              ),
              // subChild: Text("Show More Details"),
            ),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: RatingsWidget(
                  rate: reviewsCubit.rate,
                  iconSize: 26,
                  paddingBetweenIcons: 4,
                  unratedColor: LightTheme().borderColor,
                  onDateSelected: (rate) async {
                    reviewsCubit.changeRate(rate);
                    return rate;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: LightTheme().borderColor,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    await reviewsCubit.selectImages();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: reviewsCubit.images.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.photo_camera_outlined,
                                  weight: 0.1,
                                  size: 32,
                                  color: LightTheme().borderColor,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Photo",
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 17,
                                      color: LightTheme().borderColor),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: 120,
                            width: MediaHelper.width,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: reviewsCubit.images.length,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 5,
                              ),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    reviewsCubit.images[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextInputField(
                borderType: BorderType.Outline,
                hintText: 'Write a review',
                controller: reviewsCubit.reviewController,
                onChange: (p0) {},
              ),
              reviewsCubit.rate != 0.0 ||
                      reviewsCubit.images.isNotEmpty ||
                      reviewsCubit.reviewController.text != ""
                  ? BlocConsumer<ShopProductDetailsCubit,
                      ShopProductDetailsStates>(
                    listener: (context, state) {
                    },
                    builder: (context, state) {
                      ShopProductDetailsCubit shopProductDetailsCubit =
                          context.read<ShopProductDetailsCubit>();
                  
                      return CustomBtn(
                        onTap: () async {
                          await shopProductDetailsCubit.updateTotalRate(
                              productItem: productDetails,
                              rate: reviewsCubit.rate);
                          if (reviewsCubit.isEdit == false) {
                            await reviewsCubit.addReview(
                                productId: productDetails);
                          } else {
                            ReviewModel? userReview =
                                reviewsCubit.ReviewsList.firstWhere(
                              (review) => review.user_id == currentUserId,
                            );
                            await reviewsCubit.updateReview(
                                productItem: productDetails,
                                reviewItem: userReview);
                          }
                        },
                        text: Text(
                          reviewsCubit.isEdit ? "Save" : "Submit Review",
                          style: AppTextStyles.w600.copyWith(
                              color: LightTheme().background, fontSize: 20),
                        ),
                        buttonColor: LightTheme().mainColor,
                        height: 50,
                      );
                    },
                  )
                  : Container(),
            
            ],
          );
        }
      },
    );
  }
}
