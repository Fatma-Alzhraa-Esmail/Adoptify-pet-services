import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/shop/bloc/shop_cubit.dart';
import 'package:peto_care/services/shop/pages/shop_list.dart';

import '../../../routers/navigator.dart';
import '../../../routers/routers.dart';

class Services {
  final String? image;
  final String? ServicesName;
  final Function()? route;
  Cubit? cubitt;
  Widget? screen;

  Services({this.image, this.ServicesName, this.route,this.cubitt,this.screen});
  static List<Services> CreateServicesCard() {
    return [
      Services(
          image: 'assets/images/shop.png',
          ServicesName: 'Shop',
          route: () {
            CustomNavigator.push(Routes.shopFeature);
          },
          cubitt: ShopCubit(),
          screen: ShopFeature()
          ),
      Services(
          image: 'assets/images/services.png',
          ServicesName: 'services',
          route: () {
            CustomNavigator.push(Routes.servicesFeature);
          }),
      Services(
          image: 'assets/images/shop.png',
          ServicesName: 'Shop',
          route: () {
            CustomNavigator.push(Routes.servicesFeature);
          }),
    ];
  }
}
