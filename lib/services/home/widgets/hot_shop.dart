import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/components/rating_widget.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

class HotShopWidget extends StatelessWidget {
  const HotShopWidget({
    required this.productItem,
    super.key,
  });
 final ProductModel productItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1.6,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
            ]),
        // width: 185,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Container(
              width: 75,
              height: 75,
              child: CachedNetworkImage(
                imageUrl:  productItem.colors![0].images![0],
                fit: BoxFit.cover,
    
              ),
              // child: Image.network(
              //   productItem.colors![0].images![0],
              //   fit: BoxFit.cover,
              // ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '${productItem.product_name}',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
           
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 6),
             child: RatingsWidget(rate: productItem.rating!.rate!,unratedColor: LightTheme().greyTitle,paddingBetweenIcons: 3,
              onDateSelected: (rate) async{
                return rate;
              },
             ),
           ),
           
            Text(
              '\$${productItem.price!.ceil()}',
              style: TextStyle(fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
