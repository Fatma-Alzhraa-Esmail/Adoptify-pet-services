import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peto_care/utilities/components/custom_page_body.dart';
import 'package:peto_care/utilities/theme/media.dart';

import '../../../handlers/shared_handler.dart';
import '../../../routers/navigator.dart';
import '../../../routers/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacityAnimation;

  _setAnimation() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    opacityAnimation = Tween<double>(end: 1, begin: 0).animate(controller);
    controller.forward();
    controller.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        if (SharedHandler.instance!
            .getData(key: SharedKeys().isLogin, valueType: ValueType.bool)) {
          CustomNavigator.push(Routes.Navigation);
        }
        else if(SharedHandler.instance!
            .getData(key: SharedKeys().isRegister, valueType: ValueType.bool)){
                        CustomNavigator.push(Routes.Navigation);

            }
         else {
          CustomNavigator.push(Routes.onboarding);
        }
      },
    );
    _setAnimation();
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Column(
          children: [
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: opacityAnimation.value,
                child: Center(
                  child: Image.asset(
                    "assets/images/splash.png",
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
