
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/home/bloc/cubit.dart';
import 'package:adoptify/services/home/bloc/state.dart';
import 'package:adoptify/services/home/widgets/deal_of_the_day.dart';
import 'package:adoptify/services/home/widgets/hot_shop.dart';
import 'package:adoptify/services/home/widgets/services.dart';
import 'package:adoptify/services/home/widgets/top_services.dart';
import 'package:adoptify/utilities/components/component.dart';
import 'package:adoptify/utilities/components/search.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 300,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                width: 297,
                                height: 269,
                                child: Image.asset(
                                  'assets/images/slider3.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey, Colors.black12],
                        ),
                      ),
                    ),
                  ),

                  Search(),
                 Positioned(
                    top: 150,
                    left: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUMMER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            // decoration: TextDecoration.underline,
                            decorationThickness: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: 72,
                          height: 2.5,
                          child: Container(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 20,
                    child: Text(
                      '30% OFF',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocProvider(
                create: (BuildContext context) => AppCubit(),
                child: BlocConsumer<AppCubit, AppStates>(
                    listener: (BuildContext context, AppStates state) {},
                    builder: (BuildContext context, AppStates state) {
                      AppCubit cubit = AppCubit.get(context);
                      return Container(
                        // width: 60,
                        height: 80,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.services.length,
                            itemBuilder: (context, index) =>
                                MainFeaturesWidget(context, cubit.services[index])),
                      );
                    })),

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
                            itemBuilder: (context, index) => TopServicesWidget(
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
                                  childAspectRatio: 2/1.9,
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

             SizedBox(height: 5,),
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
                          padding: EdgeInsets.only(top: 5,bottom: 10),
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.deal_of_the_day.length,
                            itemBuilder: (context, index) => DealOfTheDayWidget(
                                context, cubit.deal_of_the_day[index])),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
