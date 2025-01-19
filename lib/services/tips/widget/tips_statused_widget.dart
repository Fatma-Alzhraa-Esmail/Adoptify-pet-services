
import 'package:flutter/material.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/services/tips/widget/recommended_tips.dart';
import 'package:peto_care/utilities/theme/media.dart';

// ignore: must_be_immutable
class StatusedTipsWidget extends StatelessWidget {
  StatusedTipsWidget({super.key, required this.cubit});
  TipsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaHelper.width,
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cubit.tipsWithStatus.length,
        itemBuilder: (context, index) => RecommendedTipsWidget(
          tipsItem: cubit.tipsWithStatus[index],
          tipsCubit: cubit,
        ),
      ),
    );
  }
}
