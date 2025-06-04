import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';

import 'package:peto_care/services/myaccount/widget/complete_profile.dart';
import 'package:peto_care/services/myaccount/widget/listtilewidget.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        // backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.notifications_none_outlined,
            size: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 28,
            ),
          ),
        ],
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                CustomNavigator.push(Routes.accountInfo);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/person.jpeg',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fatma Alzhraa Esmail',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'fatmaalzhraazedan@gmail.com',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 10,
            ),
            // BlocProvider(
            //     create: (BuildContext context) => CompleteProfileCubit(),
            //     child: BlocConsumer<CompleteProfileCubit,
            //             CompleteProfileStates>(
            //         listener:
            //             (BuildContext context, CompleteProfileStates state) {},
            //         builder:
            //             (BuildContext context, CompleteProfileStates state) {
            //           CompleteProfileCubit cubit =
            //               CompleteProfileCubit.get(context);
            //           return Container(
            //             width: MediaQuery.of(context).size.width,
            //             height: 130,
            //             child: ListView.builder(
            //                 itemExtent: 130,
            //                 scrollDirection: Axis.horizontal,
            //                 itemCount: cubit.completeprofilee.length,
            //                 itemBuilder: (context, index) =>
            //                     CompleteProfileWidget(
            //                         context, cubit.completeprofilee[index])),
            //           );
            //         })),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Colors.grey.shade300,
              ),
            ),
            ProfileOtherServices(
              leading: Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: LightTheme().borderColor,
                size: 24,
              ),
              title: 'Favourite',
              ontap: () {
                CustomNavigator.push(Routes.FavouriteScreen);
              },
            ),
            ProfileOtherServices(
              leading: Icon(
                Icons.local_shipping_outlined,
                size: 30,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: LightTheme().borderColor,
                size: 24,
              ),
              title: 'Transform Details',
              ontap: () {},
            ),
            ProfileOtherServices(
              leading: Icon(
                Icons.settings_suggest,
                size: 30,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: LightTheme().borderColor,
                size: 24,
              ),
              title: 'Settings',
              ontap: () {
                CustomNavigator.push(Routes.settings);
              },
            ),
            ProfileOtherServices(
              leading: Icon(
                Icons.headset_mic_outlined,
                size: 30,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: LightTheme().borderColor,
                size: 24,
              ),
              title: 'Help Center',
              ontap: () {},
            ),
            ProfileOtherServices(
              leading: Icon(
                Icons.error_outline_sharp,
                size: 30,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: LightTheme().borderColor,
                size: 24,
              ),
              title: 'About Us',
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
