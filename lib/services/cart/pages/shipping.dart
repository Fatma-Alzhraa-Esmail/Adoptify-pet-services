import 'package:flutter/material.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/confirmed.dart';
import 'package:peto_care/services/cart/widget/deliverto.dart';
import 'package:peto_care/services/cart/widget/payment_medthod.dart';

import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/media.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  int currentScreen = 0;
  List<String> appbarTitle = ["Delivered To", "Payment Methode", "Confirm"];
  List<String> buttonTitle = ["CONTINUE", "CONTINUE", "CONTINUE SHOPPING"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle[currentScreen]),
        // centerTitle: true,
        // elevation: 0.0,
        // backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Container(
        height: MediaHelper.height,
        width: MediaHelper.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    // child: Icon(Icons.location_on_outlined,color:Colors.amber,),
                    child: drawSvgIcon("location",
                        width: 30, height: 30, iconColor: Colors.amber),

                    onTap: () {
                      setState(() {
                        currentScreen = 0;
                      });
                    },
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    height: 2,
                    color: (currentScreen == 1 || currentScreen == 2)
                        ? Colors.amber
                        : Colors.grey.shade500,
                  )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentScreen = 1;
                      });
                    },
                    child: drawSvgIcon(
                      "payment",
                      width: 30,
                      height: 30,
                      iconColor: (currentScreen == 1 || currentScreen == 2)
                          ? Colors.amber
                          : Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                      child: Container(
                          height: 2,
                          color: (currentScreen == 2)
                              ? Colors.amber
                              : Colors.grey.shade500,
                          margin: EdgeInsets.symmetric(horizontal: 12))),
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentScreen = 2;
                      });
                    },
                    child: drawSvgIcon(
                      "confirm",
                      width: 30,
                      height: 30,
                      iconColor: currentScreen == 2
                          ? Colors.amber
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: MediaHelper.width, child: stepper[currentScreen]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomBtn(
                onTap: () {
                  setState(() {
                    if (currentScreen < 2) {
                      currentScreen++;
                    } else {
                      CustomNavigator.push(Routes.completeCartInfo);
                    }
                  });
                },
                text: Text(buttonTitle[currentScreen]),
                buttonColor: Colors.amber,
                height: 56,
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      )),
    );
  }

  List<Widget> stepper = [DeliverToWidget(), CartPayment(), ConfirmedWidget()];
}
