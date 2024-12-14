import 'package:flutter/material.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({
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
          "Product information",
          style: AppTextStyles.w700.copyWith(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) => Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 10,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        productItemDetails
                            .productInfo![index],
                        style: AppTextStyles.w500.copyWith(
                          color: LightTheme().greyTitle,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount:
                productItemDetails.productInfo!.length),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
