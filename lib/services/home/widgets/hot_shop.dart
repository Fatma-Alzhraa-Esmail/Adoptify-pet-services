
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:adoptify/services/home/model/hot_shop.dart';

Widget HotShopWidget(BuildContext context, HotShop hotShop) {
  bool iconn = false;
  
  return Padding(
    padding: const EdgeInsets.only(left: 7.5,right: 7.5),
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
       height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      
                      iconn = true;
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: iconn == true ? Colors.red : Colors.black,
                    )),
              ],
            ),
          ),
          Container(
            width: 75,
            height: 75,
            child: Image.asset(
              '${hotShop.image}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            '${hotShop.title}',
            style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),
          ),
          RatingBar.builder(
            initialRating: hotShop.rating!,
            minRating: 1,
            itemSize: 16,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            unratedColor: Colors.grey,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star_sharp,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          Text('\$${hotShop.price!.ceil()}',style: TextStyle(fontWeight: FontWeight.w800),)
        ],
      ),
    ),
  );
}
