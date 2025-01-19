import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/tips/manger/tips_cubit/tips_cubit.dart';
import 'package:peto_care/services/tips/repo/tips_repo_imp.dart';
import 'package:peto_care/services/tips/widget/popular_tips_widget.dart';
import 'package:peto_care/services/tips/widget/recommended_tips.dart';
import 'package:peto_care/services/tips/widget/tips_hightlighted_widget.dart';
import 'package:peto_care/services/tips/widget/tips_statused_widget.dart';
import 'package:peto_care/services/tips/widget/tips_top_header_widget.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TipsCubit(TipsRepoImp())..allOperation(),
        child: BlocConsumer<TipsCubit, TipsState>(
          listener: (context, state) {
            TipsCubit cubit = context.read<TipsCubit>();
            if (state is TipsFetchHighlightLoadedState) {
            } else if (state is TipsFetchHighlightLoadingState) {
            } else if (state is TipsFetchHighlightErrorState) {
            } else if (state is TipsFetchStatusLoadedState) {
              cubit.tipsWithStatus = state.tipsList;
            } else if (state is TipsFetchStatusLoadingState) {
            } else if (state is TipsFetchStatusErrorState) {
            } else if (state is TipsFetchLoadedState) {
              cubit.tips = state.tipsList;
            } else if (state is TipsFetchLoadingState) {
            } else if (state is TipsFetchErrorState) {}
          },
          builder: (context, state) {
            TipsCubit cubit = context.read<TipsCubit>();
            return CustomScrollView(
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
                SliverToBoxAdapter(
                    child: StatusedTipsWidget(
                  cubit: cubit,
                )),
                SliverToBoxAdapter(
                    child: HighlightedTipsWidget(
                  cubit: cubit,
                )),
                SliverToBoxAdapter(
                  child: cubit.tips.isNotEmpty
                      ? GridView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: 13, horizontal: 14),
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
                                tipsItem: cubit.tips[index], tipsCubit: cubit);
                          },
                        )
                      : Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

