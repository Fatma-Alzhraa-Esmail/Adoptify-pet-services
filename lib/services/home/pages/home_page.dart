import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/home/cubit/cubit.dart';
import 'package:peto_care/services/home/cubit/state.dart';
import 'package:peto_care/services/home/widgets/deal_of_the_day.dart';
import 'package:peto_care/services/home/widgets/header_body.dart';
import 'package:peto_care/services/home/widgets/hot_shop.dart';
import 'package:peto_care/services/home/widgets/main_features_body.dart';
import 'package:peto_care/services/home/widgets/top_services.dart';
import 'package:peto_care/utilities/components/component.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderBody(),
                SizedBox(
                  height: 10,
                ),
                MainFeaturesBody(),

// Top Services
                TitleHeadLine('Top Service', 'View All'),
                BlocProvider(
                    create: (BuildContext context) => AppCubit(),
                    child: BlocConsumer<AppCubit, AppStates>(
                        listener: (BuildContext context, AppStates state) {},
                        builder: (BuildContext context, AppStates state) {
                          AppCubit cubit = AppCubit.get(context);
                          return Container(
                            // width: 60,
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cubit.topservices.length,
                                itemBuilder: (context, index) =>
                                    TopServicesWidget(
                                        context, cubit.topservices[index])),
                          );
                        })),

                TitleHeadLine('Hot Shop', 'Views All'),

                BlocProvider(
                  create: (BuildContext context) => AppCubit(),
                  child: BlocConsumer<AppCubit, AppStates>(
                      listener: (BuildContext context, AppStates state) {},
                      builder: (BuildContext context, AppStates state) {
                        AppCubit cubit = AppCubit.get(context);
                        return Container(
                            height: 430,
                            // padding: EdgeInsets.only(right: 10),
                            child: GridView.builder(
                              // itemCount: images.length,
                              padding: EdgeInsets.symmetric(vertical: 13),
                              itemCount: cubit.hotshop.length,

                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 1.9,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2.0,
                                      mainAxisSpacing: 15.0),
                              itemBuilder: (BuildContext context, int index) {
                                return HotShopWidget(
                                    context, cubit.hotshop[index]);
                              },
                            ));
                      }),
                ),

                SizedBox(
                  height: 5,
                ),
                TitleHeadLine('Deal of the Day', 'Views All'),

                BlocProvider(
                    create: (BuildContext context) => AppCubit(),
                    child: BlocConsumer<AppCubit, AppStates>(
                        listener: (BuildContext context, AppStates state) {},
                        builder: (BuildContext context, AppStates state) {
                          AppCubit cubit = AppCubit.get(context);
                          return Container(
                            // width: 60,
                            height: 200,
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 5, bottom: 10),
                                scrollDirection: Axis.vertical,
                                itemCount: cubit.deal_of_the_day.length,
                                itemBuilder: (context, index) =>
                                    DealOfTheDayWidget(
                                        context, cubit.deal_of_the_day[index])),
                          );
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}


