import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class serviceDetailsBodyWidget extends StatelessWidget {
  const serviceDetailsBodyWidget({
    super.key,
    required this.productItemDetails,
  });

  final ProductModel productItemDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Photos",
          style: AppTextStyles.w700.copyWith(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaHelper.height * 1 / 10,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 3 &&
                    productItemDetails.serviceImages!.length > 4) {
                  productItemDetails.serviceImages!.length;
                  return Container(
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            productItemDetails.serviceImages![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.grey.withOpacity(0.1),
                          child: Center(
                            child: Text(
                              "+${productItemDetails.serviceImages!.length - 4}",
                              style: AppTextStyles.w800
                                  .copyWith(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    width: 80,
                    imageUrl: productItemDetails.serviceImages![index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              itemCount: 4),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
