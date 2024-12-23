import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/widgets/search.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/services/tips/repo/tips_repo_imp.dart';
import 'package:peto_care/services/tips/widget/popular_tips_widget.dart';
import 'package:peto_care/services/tips/widget/recommended_tips.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverToBoxAdapter(child: tipsTopHeaderWidget()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                'Let the dogs get better \nevery day.',
                style: AppTextStyles.w900.copyWith(fontSize: 25),
              ),
            ),
          ),
          SliverToBoxAdapter(child: StatusedTipsWidget()),
          SliverToBoxAdapter(child: HighlightedTipsWidget()),

          SliverToBoxAdapter(
            child: BlocProvider(
              create: (BuildContext context) =>
                  TipsCubit(TipsRepoImp())..fetchTips(),
              child: BlocConsumer<TipsCubit, TipsState>(
                  listener: (BuildContext context, TipsState state) {},
                  builder: (BuildContext context, TipsState state) {
                    TipsCubit cubit = context.read<TipsCubit>();
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 14),
                      itemCount: cubit.tips.length,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2 / 1.9,
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0),
                      itemBuilder: (BuildContext context, int index) {
                        return PopularTipsWidget(
                            tipsItem: cubit.tips[index]);
                      },
                    );
                  }),
            ),
          ),
       
       
        ],
      ),
    );
  }
}

class HighlightedTipsWidget extends StatelessWidget {
  const HighlightedTipsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TipsCubit(TipsRepoImp())..fetchHighlightTips(),
      child: BlocConsumer<TipsCubit, TipsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          TipsCubit tipsCubit = context.read<TipsCubit>();
          return tipsCubit.tipsWithHighlighit.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                        tipsCubit.tipsWithHighlighit[0].image!,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tipsCubit.tipsWithHighlighit[0].title!,
                                    style: AppTextStyles.w500.copyWith(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    tipsCubit.tipsWithHighlighit[0].subTitle!,
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
                )
              : Container();
        },
      ),
    );
  }
}

class StatusedTipsWidget extends StatelessWidget {
  const StatusedTipsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            TipsCubit(TipsRepoImp())..fetchStatusTips(),
        child: BlocConsumer<TipsCubit, TipsState>(
            listener: (BuildContext context, TipsState state) {},
            builder: (BuildContext context, TipsState state) {
              TipsCubit tipsCubit = context.read<TipsCubit>();
              return Container(
                width: MediaHelper.width,
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tipsCubit.tipsWithStatus.length,
                  itemBuilder: (context, index) => RecommendedTipsWidget(
                      tipsItem: tipsCubit.tipsWithStatus[index]),
                ),
              );
            }));
  }
}

class tipsTopHeaderWidget extends StatelessWidget {
  const tipsTopHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.1 / 1.5,
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
                      colors: [Colors.grey, Colors.black12],
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/onboarding7.jpeg',
                        )),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
          Positioned(top: 45, right: 12, left: 12, child: TopSearchBarWidget()),
        ],
      ),
    );
  }
}
