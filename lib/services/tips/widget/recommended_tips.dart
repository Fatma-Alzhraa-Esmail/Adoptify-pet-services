import 'package:flutter/material.dart';
import 'package:peto_care/services/tips/model/recommended_tips.dart';

Widget RecommendedTipsWidget(
    BuildContext context, RecommededTips recommededTips) {
  // bool iconn = false;
  return Padding(
    padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
    child: Container(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 140,
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
                  image: AssetImage('${recommededTips.image}'),
                  fit: BoxFit.cover),
              backgroundBlendMode: BlendMode.dstATop,
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white38, Colors.white54],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 15,
                    // left: 15,
            
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                       width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: recommededTips.colorStatus,
                            ),
                            child: Text(
                              '${recommededTips.Status}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
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
                      ),
                    )),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${recommededTips.tipsName}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${recommededTips.description}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
