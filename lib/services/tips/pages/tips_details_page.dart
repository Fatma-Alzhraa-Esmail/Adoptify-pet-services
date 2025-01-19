import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class TipsDetailsPage extends StatelessWidget {
  const TipsDetailsPage({super.key, required this.tipsItemDetails});
  final TipsModel tipsItemDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () async{
              Navigator.pop(context, true);

              //  await BlocProvider.of<TipsCubit>(context).allOperation();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AddRemoveFromFavouriteWidget(
              featureType: FeatureType.Tips,
              tipsItem: tipsItemDetails,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Text(
                  tipsItemDetails.title ?? "",
                  style: AppTextStyles.w800.copyWith(fontSize: 26),
                ),
                Text(
                    "${timeago.format(tipsItemDetails.created_at!)} · ${DateFormat.jm().format(tipsItemDetails.created_at!)}",
                    style: AppTextStyles.w400
                        .copyWith(color: LightTheme().greyTitle)),
                Text(
                  tipsItemDetails.subTitle ?? "",
                  style: AppTextStyles.w500.copyWith(fontSize: 15),
                ),
                AspectRatio(
                  aspectRatio: 2.1 / 1.5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                '${tipsItemDetails.image}'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Text(
                  tipsItemDetails.description ?? "",
                  style: AppTextStyles.w500.copyWith(fontSize: 15),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 0,
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: LightTheme().redColor,
                    child:
                        Image.asset(Assets.assetsImagesGoogleRemovebgPreview1),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: LightTheme().blueColor,
                    child: Image.asset(
                      Assets.assetsImagesFacebookpngRemovebgPreview,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Row(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => CustomNavigator.push(Routes.TipsComments,arguments: tipsItemDetails),
                        child: Container(
                          decoration: BoxDecoration(
                              color: LightTheme().background,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Color(0xFF000000).withOpacity(0.08),
                                    spreadRadius: 1,
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Icon(
                                Icons.comment_outlined,
                                color: LightTheme().mainColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: LightTheme().mainColor,
                        child: Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
