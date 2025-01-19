import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/pages/tips_details_page.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

// ignore: must_be_immutable
class RecommendedTipsWidget extends StatelessWidget {
  RecommendedTipsWidget({
    super.key,
    required this.tipsItem,
    required this.tipsCubit,
  });
  TipsModel tipsItem;
  TipsCubit tipsCubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        // CustomNavigator.push(Routes.TipsDetails, arguments: tipsItem);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return TipsDetailsPage(tipsItemDetails: tipsItem);
          },
        )).then(
          (value) async{
          await  tipsCubit.allOperation();
       
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
        child: AspectRatio(
          aspectRatio: 2.5 / 1.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                isLoading: tipsCubit.tipsWithStatusIsLoading,
                child: AspectRatio(
                  aspectRatio: 2.5 / 1.2,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                            blurRadius: 1.4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            '${tipsItem.image}',
                          ),
                          fit: BoxFit.cover,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.white38,
                            Colors.white54
                          ],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.topCenter,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        // width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerLoading(
                              isLoading: tipsCubit.tipsWithStatusIsLoading,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: tipsItem.status == "New"
                                      ? Colors.redAccent
                                      : Colors.amber,
                                ),
                                child: Text(
                                  '${tipsItem.status}',
                                  style: AppTextStyles.w600.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            ShimmerLoading(
                              isLoading: tipsCubit.tipsWithStatusIsLoading,
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.white60,
                                child: Center(
                                  child: AddRemoveFromFavouriteWidget(
                                    tipsItem: tipsItem,
                                    featureType: FeatureType.Tips,
                                    padding: EdgeInsets.all(0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tipsItem.title}',
                      style: AppTextStyles.w700.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${tipsItem.description}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
