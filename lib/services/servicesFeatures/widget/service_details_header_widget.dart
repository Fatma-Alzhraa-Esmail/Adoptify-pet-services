import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';

import '../../../utilities/theme/colors/light_theme.dart';

class ServiceDetailsHeaderWidget extends StatelessWidget {
  const ServiceDetailsHeaderWidget({
    super.key,
    required this.productItemDetails,
  });

  final ProductModel productItemDetails;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1.5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                productItemDetails.coverImage!,
              ),
              fit: BoxFit.cover),
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.black12],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: LightTheme().background,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      AddRemoveFromFavouriteWidget(
                        productItem: productItemDetails,
                        featureType: FeatureType.Shop,
                        unCheckedColor:
                            LightTheme().background,
                        iconSize: 26,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.share_outlined,
                          color: LightTheme().background,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
