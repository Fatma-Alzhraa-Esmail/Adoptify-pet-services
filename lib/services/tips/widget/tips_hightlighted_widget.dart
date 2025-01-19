import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

import '../../../routers/navigator.dart';

class HighlightedTipsWidget extends StatelessWidget {
  HighlightedTipsWidget({super.key, required this.cubit});
  TipsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return cubit.tipsWithHighlighit.isNotEmpty
        ? InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => CustomNavigator.push(Routes.TipsDetails,
                arguments: cubit.tipsWithHighlighit[0]),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
              child: Container(
                width: MediaHelper.width,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black38,
                                  Colors.black54,
                                  Colors.black87,
                                ],
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    cubit.tipsWithHighlighit[0].image!,
                                  )),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 245,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.tipsWithHighlighit[0].title!,
                                style: AppTextStyles.w500.copyWith(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                cubit.tipsWithHighlighit[0].subTitle!,
                                style: AppTextStyles.w800.copyWith(
                                    color: LightTheme().background,
                                    fontSize: 25,
                                    overflow: TextOverflow.ellipsis),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
