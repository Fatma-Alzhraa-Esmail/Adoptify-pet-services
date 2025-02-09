import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/manager/mainFeatures/main_feature_cubit.dart';
import 'package:peto_care/services/home/manager/mainFeatures/main_feature_state.dart';
import 'package:peto_care/services/home/repo/home_repo_impl.dart';
import 'package:peto_care/services/home/widgets/services.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';

class MainFeaturesBody extends StatelessWidget {
  const MainFeaturesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            MainFeatureCubit(HomeRepoImpl())..fetchMainFeatures(),
        child: BlocConsumer<MainFeatureCubit, MainFeatureState>(
            listener: (BuildContext context, MainFeatureState state) {
          MainFeatureCubit mainFeaturesCubit = context.read<MainFeatureCubit>();
          if (state is MainFeaturesLoaded) {
            mainFeaturesCubit.mainFeatures = state.features;
          } else if (state is MainFeaturesLoading) {
            print("shimmer1 $mainFeaturesCubit.categoriesLoading");
          } else if (state is MainFeaturesLoaded) {
            print("shimmer2 $mainFeaturesCubit.categoriesLoading");
          }
        }, builder: (BuildContext context, MainFeatureState state) {
          MainFeatureCubit mainFeaturesCubit = context.read<MainFeatureCubit>();
          print("sdsfsfes: ${mainFeaturesCubit.categoriesLoading}");
          return AspectRatio(
            aspectRatio: 4 / 1,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mainFeaturesCubit.mainFeatures.length,
                itemBuilder: (context, index) => ShimmerLoading(
                      isLoading: mainFeaturesCubit.categoriesLoading,
                      child: MainFeaturesWidget(
                          context,
                          mainFeaturesCubit.mainFeatures[index],
                          mainFeaturesCubit),
                    )),
          );
        }));
  }
}
