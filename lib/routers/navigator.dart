import 'package:flutter/material.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/auth/Login/pages/login.dart';
import 'package:peto_care/services/cart/pages/cart.dart';
import 'package:peto_care/services/cart/pages/cart_edit.dart';
import 'package:peto_care/services/cart/pages/complete_cart.dart';
import 'package:peto_care/services/cart/pages/shipping.dart';
import 'package:peto_care/services/myaccount/pages/account_info.dart';
import 'package:peto_care/services/myaccount/pages/add_new_address.dart';
import 'package:peto_care/services/myaccount/pages/add_new_card.dart';
import 'package:peto_care/services/myaccount/pages/address.dart';
import 'package:peto_care/services/myaccount/pages/history.dart';
import 'package:peto_care/services/myaccount/pages/settings.dart';
import 'package:peto_care/services/servicesFeatures/pages/services_list_page.dart';
import 'package:peto_care/services/shop/pages/shop_list.dart';
import 'package:peto_care/services/verification_code/pages/phonenumberverfication.dart';
import 'package:peto_care/services/auth/register/pages/register.dart';
import 'package:peto_care/services/verification_code/pages/verviy.dart';
import 'package:peto_care/services/home/pages/Navigation.dart';
import 'package:peto_care/services/home/pages/home_page.dart';
import 'package:peto_care/services/myaccount/pages/account.dart';
import 'package:peto_care/services/onboarding_screen.dart/onboarding_page.dart';
import 'package:peto_care/services/tips/pages/tips.dart';

import '../services/splash/pages/splash_page.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.easeInOut;
var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState = GlobalKey<ScaffoldMessengerState>();

  static _pageRoute(Widget screen) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return _pageRoute( LoginScreen());
      case Routes.splash:
        return _pageRoute(const SplashPage());
     
      case Routes.home:
        return _pageRoute( HomePage());
      case Routes.onboarding:
       return _pageRoute( OnboardingScreen());
      case Routes.register:
       return _pageRoute( RegisterScreen());
      case Routes.verfication:
       return _pageRoute( VerifyPhoneScreen());
      case Routes.phone:
       return _pageRoute( phone());
      case Routes.Navigation:
       return _pageRoute( NavigationScreen());
      case Routes.Tips:
       return _pageRoute( TipsScreen());
      case Routes.account:
       return _pageRoute( AccountScreen());
      case Routes.accountInfo:
       return _pageRoute( AccountInfo());
      case Routes.addnewpaymentCard:
       return _pageRoute( AddNewCard());
      case Routes.address:
       return _pageRoute( Address());
      case Routes.history:
       return _pageRoute( History());
      case Routes.servicesFeature:
      //  return _pageRoute( ServicesFeature());
       return _pageRoute( ServicesPage());
      case Routes.shopFeature:
       return _pageRoute( ShopFeature());
      case Routes.addNewAddress:
       return _pageRoute( AddNewAddress());
      case Routes.settings:
       return _pageRoute( SettingsScreen());
      case Routes.cart:
       return _pageRoute( CartScreen());
      case Routes.cartEdit:
       return _pageRoute( CartEditScreen());
      case Routes.shipping:
       return _pageRoute( ShippingScreen());
      case Routes.completeCartInfo:
       return _pageRoute( CompletedCartInfo());

    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName, {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }
}
