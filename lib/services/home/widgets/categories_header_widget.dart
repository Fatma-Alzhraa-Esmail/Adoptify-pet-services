import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peto_care/services/home/cubit/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/utilities/components/shimmer/shimmer.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';

class CategoriesHeaderWidget extends StatelessWidget {
  const CategoriesHeaderWidget({
    super.key,
    required this.mainFeatureCategoriesCubit,
    required this.id,
  });

  final MainFeatureCategoriesCubit mainFeatureCategoriesCubit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        height: MediaHelper.height * 1 / 10,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final category =
                mainFeatureCategoriesCubit.mainFeaturesCategoriesList[index];

            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:
                      category.id == mainFeatureCategoriesCubit.selectedCategory
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withAlpha(16),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: Offset(0.2, 2),
                              ),
                            ],
                  border: Border.all(
                      width: category.id ==
                              mainFeatureCategoriesCubit.selectedCategory
                          ? 2.5
                          : 0,
                      color: category.id ==
                              mainFeatureCategoriesCubit.selectedCategory
                          ? LightTheme().mainColor
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: ShimmerLoading(
                        isLoading:
                            mainFeatureCategoriesCubit.subCategoriesLoading,
                        child: SvgPicture.network(
                          '${category.image}',
                          width: 64,
                          height: 64,
                          fit: BoxFit.contain,
                        ),
                      )),
                      SizedBox(
                        height: 4,
                      ),
                      ShimmerLoading(
                        isLoading:
                            mainFeatureCategoriesCubit.subCategoriesLoading,
                        child: Text(
                          category.category_name!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                await mainFeatureCategoriesCubit.changeCurrentCategory(
                    id: category.id);
                await mainFeatureCategoriesCubit.AllOperation(
                    id: id, categoryId: category.id);

                // mainFeatureCategoriesCubit
                //     .selectedCategory = category.id;
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemCount:
              mainFeatureCategoriesCubit.mainFeaturesCategoriesList.length,
        ),
      ),
    );
  }
}
