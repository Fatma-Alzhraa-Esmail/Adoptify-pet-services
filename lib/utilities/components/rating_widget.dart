import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

class RatingsWidget extends StatelessWidget {
  const RatingsWidget({
    super.key,
    required this.productItem,
     this.unratedColor,
     this.iconSize,
     this.paddingBetweenIcons,
  });

  final ProductModel productItem;
  final Color? unratedColor;
  final double? iconSize;
  final double? paddingBetweenIcons;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: productItem.rating!.rate as double,
      minRating: 0,
      itemSize: iconSize ??16,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      unratedColor:unratedColor?? LightTheme().background,
      itemPadding: EdgeInsets.symmetric(horizontal: paddingBetweenIcons??1.5),
      itemBuilder: (context, index) {
        return index < productItem.rating!.rate!
            ? drawSvgIcon('star', iconColor: LightTheme().mainColor)
            : drawSvgIcon('star_outline', iconColor: unratedColor?? LightTheme().background);
      },
      updateOnDrag: false,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
