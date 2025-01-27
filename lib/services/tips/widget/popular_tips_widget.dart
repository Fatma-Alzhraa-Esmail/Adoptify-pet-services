import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/services/tips/model/tips_model.dart';
import 'package:peto_care/services/tips/pages/tips_details_page.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'package:peto_care/utilities/theme/media.dart';

class PopularTipsWidget extends StatelessWidget {
   const PopularTipsWidget({
    super.key,
    required this.tipsItem,
   required this.tipsCubit,
    
  });
  final TipsModel tipsItem;
 final TipsCubit? tipsCubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async{
         Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return TipsDetailsPage(tipsItemDetails: tipsItem);
          },
        )).then(
          (value) async{
          await  tipsCubit!.allOperation();
       
          },
        );
      },
      child: Container(
        width: MediaHelper.width,
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 1.4,
                    offset: Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                    image: CachedNetworkImageProvider('${tipsItem.image}'),
                    fit: BoxFit.cover),
                backgroundBlendMode: BlendMode.dstATop,
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white38, Colors.white54],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: 10,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ShimmerLoading(
                            isLoading: tipsCubit!.tipsIsLoading,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white60,
                              child: Center(
                                child: AddRemoveFromFavouriteWidget(featureType: FeatureType.Tips,padding: EdgeInsets.all(0),tipsItem: tipsItem,),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              width: MediaHelper.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaHelper.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${tipsItem.title}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            '${tipsItem.description}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade600),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
