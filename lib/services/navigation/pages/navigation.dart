import 'package:peto_care/services/navigation/cubit/cubit.dart';
import 'package:peto_care/services/navigation/cubit/state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if(state is AppChangeBottomNavBarState){
              
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: Material(
                elevation: 20.0,
                shadowColor: Colors.black,
                // borderRadius: BorderRadius.circular(15),
                borderOnForeground: true,
                color: const Color.fromARGB(255, 245, 239, 239),
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  
                ),
                child: CurvedNavigationBar(
                  height: 55,
                  items: <Widget>[
                    Icon(
                      CupertinoIcons.home,
                      size: 30,
                      color: cubit.currentIndex == 0
                          ? Colors.white
                          : Colors.black54,
                    ),
                    Icon(
                      CupertinoIcons.layers,
                      size: 30,
                      color: cubit.currentIndex == 1
                          ? Colors.white
                          : Colors.black54,
                    ),
                    Icon(
                      CupertinoIcons.calendar,
                      size: 30,
                      color: cubit.currentIndex == 2
                          ? Colors.white
                          : Colors.black54,
                    ),
                    Icon(
                      Icons.room_outlined,
                      size: 30,
                      color: cubit.currentIndex == 3
                          ? Colors.white
                          : Colors.black54,
                    ),
                    Icon(
                      CupertinoIcons.person,
                      size: 30,
                      color: cubit.currentIndex == 4
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ],
                  // color: Colors.white,

                  buttonBackgroundColor: Colors.amber[600],
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                  animationCurve: Curves.easeIn,

                  animationDuration: const Duration(milliseconds: 400),

                  onTap: (index) {
                    cubit.changeIndex(index);
                  },
                ),
              ),
            );
          }),
    );
  }
}
