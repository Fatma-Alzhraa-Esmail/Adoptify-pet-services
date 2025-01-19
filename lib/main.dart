import 'package:peto_care/firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:peto_care/base/blocs/lang_bloc.dart';

import 'package:peto_care/base/blocs/theme_bloc.dart';

import 'package:peto_care/handlers/shared_handler.dart';

import 'package:peto_care/network/network_handler.dart';

import 'package:peto_care/routers/navigator.dart';

import 'package:peto_care/routers/routers.dart';

import 'package:peto_care/utilities/theme/colors/colors.dart';


import 'package:peto_care/utilities/theme/text_styles.dart';

import 'handlers/localization_handler.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SharedHandler.init();

  NetworkHandler.init();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  MyApp({super.key}) {

    langBloc.initLang();

    themeBloc.initTheme();

  }


  // This widget is the root of your application.

  @override

  Widget build(BuildContext context) {

    return StreamBuilder<String?>(

      stream: langBloc.langStream,

      builder: (context, snapshot) {

        return StreamBuilder<ColorsTheme?>(

            stream: themeBloc.themeStream,

            builder: (context, snapshot) {

              // ColorsTheme theme = themeBloc.theme.valueOrNull ?? LightTheme();

              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

                statusBarColor: Colors.transparent,

                statusBarIconBrightness: Brightness.light,

                systemNavigationBarColor: Colors.transparent,

                systemNavigationBarIconBrightness: Brightness.light,

              ));

              return MaterialApp(

                title: 'Project Title',

                theme: ThemeData(

                    pageTransitionsTheme: const PageTransitionsTheme(

                      builders: {

                        TargetPlatform.android:

                            CupertinoPageTransitionsBuilder(),

                        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),

                      },

                    ),
                    
                    textTheme: TextTheme(
                      bodyMedium: TextStyle(
                        color:
                            Colors.black, // Set the default text color to black
                      ),

                    ),


                   
                    appBarTheme: AppBarTheme(
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        // foregroundColor: Colors.white,
                        elevation: 0.0,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                          size: 26,
                        ),
                        actionsIconTheme: IconThemeData(
                          color: Colors.black,
                          size: 26,
                        ),
                        titleTextStyle:
                            AppTextStyles.w700.copyWith(fontSize: 20)),

                    // colorScheme: ColorScheme(

                    //   primary: theme.primary,

                    //   onBackground: theme.background,

                    //   onError: theme.error,

                    //   onSecondary: theme.secondery,

                    //   onSurface: Colors.white,

                    //   background: theme.background,

                    //   secondary: theme.secondery,

                    //   surface: Color(0xFF0A0E21),

                    //   error: theme.error,

                    //   onPrimary: theme.primary,

                    //   brightness: Brightness.dark,

                    // ),

                    fontFamily:

                        langBloc.lang.valueOrNull == 'en' ? "roboto" : "cairo",

                    scaffoldBackgroundColor: Colors.white,

                    primaryColor: Colors.black,

                    primaryColorDark: Colors.black,

                    dividerColor: Colors.black,

                    primaryColorLight: Colors.black,

                    ),
                color: Colors.black,

                debugShowCheckedModeBanner: false,

                initialRoute: Routes.splash,

                navigatorKey: CustomNavigator.navigatorState,

                navigatorObservers: [CustomNavigator.routeObserver],

                scaffoldMessengerKey: CustomNavigator.scaffoldState,

                onGenerateRoute: CustomNavigator.onCreateRoute,


                // to tell the app what the language should support

                supportedLocales: const [Locale("en"), Locale("ar")],


                // to tell the app what the components should follow the determined language

                localizationsDelegates: const [

                  AppLocale.delegate,

                  GlobalMaterialLocalizations.delegate,

                  GlobalWidgetsLocalizations.delegate,

                  GlobalCupertinoLocalizations.delegate,

                ],

                localeResolutionCallback: (currentLang, supportedLangs) {

                  // String? savedLgnCode = pref!.getString("lgnCode");

                  if (currentLang != null) {

                    for (Locale locale in supportedLangs) {

                      if (locale.languageCode == currentLang.languageCode) {
                        return locale;
                      }

                    }

                  }

                  return supportedLangs.first;

                },

                locale: Locale(langBloc.lang.valueOrNull ?? "en"),

                // home:CustomNavigator.push(Routes.splash),

              );

            });

      },

    );

  }

}

// import 'package:flutter/material.dart';
// import 'package:peto_care/dynamic_linking/bloc.dart';
// import 'package:peto_care/dynamic_linking/poc.dart';
// import 'package:peto_care/firebase_options.dart';
// import 'package:peto_care/handlers/shared_handler.dart';
// import 'package:peto_care/network/network_handler.dart';
// import 'package:provider/provider.dart';


// void main() async {

//   WidgetsFlutterBinding.ensureInitialized();

//   await SharedHandler.init();

//   NetworkHandler.init();
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


//   runApp(PocApp());

// }

// class PocApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     DeepLinkBloc _bloc = DeepLinkBloc();
//     return MaterialApp(
//         title: 'Flutter and Deep Links PoC',
//         theme: ThemeData(
//             primarySwatch: Colors.blue,
//             textTheme: TextTheme(
//               bodyMedium: TextStyle(
//                 fontWeight: FontWeight.w300,
//                 color: Colors.blue,
//                 fontSize: 25.0,
//               ),
//             )),
//         home: Scaffold(
//             body: Provider<DeepLinkBloc>(
//                 create: (context) => _bloc,
//                 dispose: (context, bloc) => bloc.dispose(),
//                 child: PocWidget())));
//   }
// }