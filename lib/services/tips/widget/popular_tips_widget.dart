import 'package:flutter/material.dart';
import 'package:peto_care/services/tips/model/popular_tips.dart';
import 'package:peto_care/utilities/theme/media.dart';

Widget PopularTipsWidget(BuildContext context, PopularTips popularTips) {
  return Container(
    width: MediaHelper.width,
    child: Padding(
      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 20),
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
                  image: AssetImage('${popularTips.image}'), fit: BoxFit.cover),
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
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.white60,
                          child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 24,
                                  weight: 5,
                                )),
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
                          '${popularTips.title}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '${popularTips.descriptionPopTips}',
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
