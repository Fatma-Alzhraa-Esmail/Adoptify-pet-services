import 'package:flutter/material.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/cart/widget/cart_product.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => CustomNavigator.pop(),
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Cart",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14, top: 14),
            child: GestureDetector(
              onTap: () {
                CustomNavigator.push(Routes.cartEdit);
              },
              child: Text(
                "Edit",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CartProductWidget(),
                    CartProductWidget(),
                    CartProductWidget(),
                    CartProductWidget(),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    color: Colors.grey.shade400,
                    height: 2,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Text("\$54",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      Text("-",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Summary",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      Text("-",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  CustomBtn(
                    buttonColor: Colors.amber,
                    height: 55,
                    text: Text("Pay"),
                    onTap: () {
                      CustomNavigator.push(Routes.shipping);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
