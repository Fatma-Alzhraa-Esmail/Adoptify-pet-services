import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/home/manager/mainFeatures/main_feature_cubit.dart';
import 'package:peto_care/services/home/manager/mainFeatures/main_feature_state.dart';
import 'package:peto_care/services/home/manager/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';

Widget MainFeaturesWidget(
    BuildContext context,
    MainFeaturesModel mainFeatureItem,
    MainFeatureCubit mainFeatureCubitInstance) {
  return BlocListener<MainFeatureCubit, MainFeatureState>(
    listener: (context, state) {
      if (state is MainFeaturesSelectCategory) {
        mainFeatureCubitInstance.selectedMainFeatureCategory = state.id;
      } else if (state is MainFeaturesLoading) {
        print("shimmer3 $mainFeatureCubitInstance.categoriesLoading");
      } else if (state is MainFeaturesLoaded) {
        print("shimmer4 $mainFeatureCubitInstance.categoriesLoading");
      }
    },
    child: BlocProvider(
      create: (context) => MainFeatureCategoriesCubit(),
      child:
          BlocConsumer<MainFeatureCategoriesCubit, MainFeatureCategoriesState>(
        listener: (context, state) {
          var mainFeaturesCategoriesCubit =
              context.read<MainFeatureCategoriesCubit>();
          if (state is MainFeaturesCategoriesAllProductsLoaded) {
            mainFeaturesCategoriesCubit.mainFeaturesCategoriesList =
                state.products;
            mainFeaturesCategoriesCubit.selectedCategory =
                state.selectedSubCategory;

            print(
                "Hello from here22: ${mainFeaturesCategoriesCubit.selectedCategory}");
            mainFeatureCubitInstance.categoriesLoading = false;
          }
          else if (state is MainFeaturesLoading) {
        print("shimmer3 $mainFeatureCubitInstance.categoriesLoading");
      } else if (state is MainFeaturesLoaded) {
        print("shimmer4 $mainFeatureCubitInstance.categoriesLoading");
      }
        
        },
        builder: (context, state) {
          var mainFeaturesCategoriesCubit =
              context.read<MainFeatureCategoriesCubit>();
          print(
              "Hello from here5: ${mainFeaturesCategoriesCubit.selectedCategory}");
          return Padding(
            padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () async {
                await mainFeatureCubitInstance.selectCurrentCategory(
                    id: mainFeatureItem.id);
                await mainFeaturesCategoriesCubit.AllOperation(
                    id: mainFeatureItem.id);

                await CustomNavigator.push(Routes.shopFeature, arguments: {
                  'id': mainFeatureItem.id,
                  'selectedCategoryId':
                      mainFeaturesCategoriesCubit.selectedCategory,
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(36),
                        spreadRadius: 0.5,
                        blurRadius: 1.4,
                        offset: Offset(0, 0.8),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoading(
                      isLoading: mainFeatureCubitInstance.categoriesLoading,
                      child: SvgPicture.network(
                        '${mainFeatureItem.image}',
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${mainFeatureItem.main_feature_name}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    // Text(
                    //   '${mainFeatureItem.id}',
                    //   style: TextStyle(fontWeight: FontWeight.w500),
                    // )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
