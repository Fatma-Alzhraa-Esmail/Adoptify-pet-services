import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/add_remove_from_Favourite_widget.dart';
import 'package:peto_care/services/favourites/model/favourite_model.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/components/rating_widget.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import '../../../utilities/theme/text_styles.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        CustomNavigator.push(Routes.serviceDetails, arguments: item);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(item.colors![0].images![0]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              Colors.grey.shade100.withOpacity(0.6),
                          child: AddRemoveFromFavouriteWidget(
                            productItem: item,
                            featureType: FeatureType.Service,
                            padding: EdgeInsets.all(0),
                            iconSize: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.product_name ?? "",
                    style: AppTextStyles.w800.copyWith(fontSize: 20),
                  ),
                  Text(
                    '\$${item.price!.toStringAsFixed(0)}',
                    style: AppTextStyles.w800.copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RatingsWidget(
                        rate: item.rating!.rate!,
                        onDateSelected: (rate) async {
                          print(rate);
                          return rate;
                        },
                        unratedColor: LightTheme().borderColor,
                      ),
                      Text(' ${item.rating!.rate}',
                          style: AppTextStyles.w600.copyWith(fontSize: 16)),
                      Text(
                        '(${NumberFormat.decimalPattern().format(item.rating!.rate_count)} Ratings)',
                        style: AppTextStyles.w500.copyWith(
                            fontSize: 16,
                            color: LightTheme().greyTitle.withAlpha(200)),
                      ),
                    ],
                  ),
                  Text(
                    '/tag',
                    style: AppTextStyles.w500.copyWith(
                        fontSize: 16,
                        color: LightTheme().greyTitle.withAlpha(200)),
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
