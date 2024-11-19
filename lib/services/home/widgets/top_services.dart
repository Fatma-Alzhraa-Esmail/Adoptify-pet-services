
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:adoptify/services/home/model/top_services.dart';

Widget TopServicesWidget(BuildContext context, TopServices service) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
            ]),
        //  width: 185,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage('${service.image}'),
                      fit: BoxFit.cover,
                    )),
                width: 300,
                // child: Image.asset(
                //   '${service.image}',
                //   fit: BoxFit.cover,
                // ),
              ),
              Container(
                width: 300,
                height: 290,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.dstATop,
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      // Colors.grey.shade900,
                      // Colors.grey,
                      // Colors.black87,
                      Colors.black,
                      Colors.black,
                      
                      // Colors.white12
                    ],
                  ),
                ),
              ),
              Positioned(
                  // left: 10,
                  bottom: 40,
                  child: Container(
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${service.title}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 19,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // SizedBox(
                          //   width: 15,
                          // ),
                          Text('\$${service.price!.ceil()}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  )),

              Positioned(
                  // left: 10,
                  bottom: 15,
                  child: Container(
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                itemSize: 16,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                unratedColor: Colors.white,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_sharp,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  
                                  
                                  print(rating);
                                },
                              ),
                              Text(
                                '(${service.n_rating} Ratings)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),

                          // SizedBox(
                          //   width: 15,
                          // ),
                          Text('${service.ServicesName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19)),
                        ],
                      ),
                    ),
                  ))
              // Text(
              //   '${service.ServicesName}',
              //   style: TextStyle(fontWeight: FontWeight.w500),
              // )
            ],
          ),
        ),
      ),
    ),
  );
}
