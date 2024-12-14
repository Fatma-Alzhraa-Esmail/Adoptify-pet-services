import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

class RatingsWidget extends StatelessWidget {
  const RatingsWidget(
      {super.key,
      required this.rate,
      this.unratedColor,
      this.iconSize,
      this.paddingBetweenIcons,
     required this.onDateSelected});

  final num rate;
  final Color? unratedColor;
  final double? iconSize;
  final double? paddingBetweenIcons;
  final Future Function(num rate) onDateSelected;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate as double,
      minRating: 0,
      itemSize: iconSize ?? 16,
      direction: Axis.horizontal,
       allowHalfRating: false,
      itemCount: 5,
      unratedColor: unratedColor ?? LightTheme().background,
      itemPadding: EdgeInsets.symmetric(horizontal: paddingBetweenIcons ?? 1.5),
      itemBuilder: (context, index) {
        return index < rate
            ? drawSvgIcon('star', iconColor: LightTheme().mainColor)
            : drawSvgIcon('star_outline',
                iconColor: unratedColor ?? LightTheme().background);
      },
      updateOnDrag: false,
      onRatingUpdate: (rating)  {
        print(rating);
        onDateSelected(rating);
      },
    );
  }
}
