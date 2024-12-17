import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/manager/main_faeture_categories/main_feature_categories_cubit.dart';
import 'package:peto_care/services/home/model/main_features_model.dart';
import 'package:peto_care/services/home/widgets/categories_header_widget.dart';
import 'package:peto_care/services/home/widgets/products_widgets.dart';
import 'package:peto_care/utilities/theme/media.dart';

class MainFeatureCategories extends StatelessWidget {
  const MainFeatureCategories(
    this.id,
    this.selectedCategoryId, this.maniCategory,{
    super.key,
  });
  final String id;
  final String selectedCategoryId;
  final MainFeaturesModel maniCategory;
  @override
  Widget build(BuildContext context) {
    print("hereeeee223 id: $id   hereeeee223 id: $selectedCategoryId");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${maniCategory.main_feature_name}',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Icon(Icons.filter_alt_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      
      
      body: CustomScrollView(
        slivers: [
          BlocProvider(

            create: (context) => MainFeatureCategoriesCubit()
              ..AllOperation(id: id, categoryId: selectedCategoryId),
         
            child: BlocConsumer<MainFeatureCategoriesCubit,
                MainFeatureCategoriesState>(
              listener: (context, state) {
                var mainFeatureCategoriesCubit =
                    context.read<MainFeatureCategoriesCubit>();
                if (state is MainFeaturesCategoriesLoaded) {
                  mainFeatureCategoriesCubit.mainFeaturesCategoriesList =
                      state.features;
                   if (mainFeatureCategoriesCubit.selectedCategory == '') {
                    mainFeatureCategoriesCubit.changeCurrentCategory(
                        id: selectedCategoryId);
                  }
                } else if (state is MainFeaturesCategoriesLoading) {
                 
                } else if (state
                    is MainFeaturesCategoriesSpecificProductsLoading) {
                } else if (state
                    is MainFeaturesCategoriesSpecificProductsLoaded) {
                  mainFeatureCategoriesCubit.products = state.products;
                } else if (state is MainFeaturesChangeSelectedCategory) {
                 

                }
              },
              builder: (context, state) {
                var mainFeatureCategoriesCubit =
                    context.read<MainFeatureCategoriesCubit>();

                return SliverFillRemaining(
                  hasScrollBody: true,
                  child: Container(
                    height: MediaHelper.height,
                    child: Column(
                      children: [
                        CategoriesHeaderWidget(mainFeatureCategoriesCubit: mainFeatureCategoriesCubit, id: id),
                        SizedBox(
                          height: 8,
                        ),
                        ProductsWidgets(mainFeatureCategoriesCubit: mainFeatureCategoriesCubit),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

