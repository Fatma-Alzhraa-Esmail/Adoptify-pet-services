import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peto_care/services/home/cubit/cubit.dart';
import 'package:peto_care/services/home/cubit/state.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {},
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: Material(
                elevation: 10.0,
                // shadowColor: Colors.black54,
                // borderRadius: BorderRadius.circular(15),
                // borderOnForeground: true,
                surfaceTintColor: Colors.white,
                // color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CurvedNavigationBar(
                  height: 55,
                  items:  <Widget>[
                    
                    Icon(
                      CupertinoIcons.home,
                      size: 30,
                      color: cubit.currentIndex == 0 ? Colors.white : Colors.black54,
                    ),
                    Icon(CupertinoIcons.layers, size: 30, color: cubit.currentIndex == 1 ? Colors.white : Colors.black54,),
                    Icon(CupertinoIcons.calendar,
                        size: 30,  color: cubit.currentIndex == 2 ? Colors.white : Colors.black54,),
                    Icon(Icons.room_outlined,
                        size: 30,  color: cubit.currentIndex == 3 ? Colors.white : Colors.black54,),
                    Icon(CupertinoIcons.person,
                        size: 30,  color: cubit.currentIndex == 4 ? Colors.white : Colors.black54,),
                        
                  ],
                  // color: Colors.white,

                  buttonBackgroundColor: Colors.amber[600],


                  // backgroundColor: Color.fromARGB(255, 246, 241, 241),
                  // f0f0f0
                  backgroundColor:HexColor("#f0f0f0"),
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
