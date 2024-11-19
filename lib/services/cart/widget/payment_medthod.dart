import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adoptify/services/cart/bloc/cart_cubit.dart';
import 'package:adoptify/services/cart/bloc/cart_state.dart';
import 'package:adoptify/utilities/components/custom_btn.dart';
import 'package:adoptify/utilities/theme/media.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  TextEditingController cardMethodController =
      TextEditingController(text: "VISA **** **** 5904");
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: BlocProvider(
            create: (BuildContext context) => CartCubit(),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Container(
                  width: MediaHelper.width,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showMyDialog(context);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.amber, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1.6,
                                  blurRadius: 1.4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Image.asset(
                                        "assets/images/payment-removebg-preview.png")),
                                Text(
                                  "Card",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            // border: Border.all(color: Colors.amber),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1.6,
                                blurRadius: 1.4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                "assets/images/cash1.png",
                                fit: BoxFit.cover,
                              )),
                              Text(
                                "Cash",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: TextFormField(
              controller: cardMethodController,
              
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.only(right: 20),
                prefixText: "VISA ",
                prefixStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(255, 4, 93, 137),
                  fontSize: 18,
                ),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.grey.shade500),
                suffixIcon: Icon(
                  Icons.done,
                  color: Colors.amber,
                  size: 28,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: GestureDetector(
            child: Text(
              "Choose other card",
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          content: Container(
            // width: MediaHelper.width,
            height: 250,
            child: Center(
              child: Column(
                            // mainAxisSize: MainAxisSize.min,
            
                children: [
                  Expanded(child: Image.asset("assets/images/choose_card.png",fit: BoxFit.cover,))
                ],
              ),
            ),
          ),
          alignment: Alignment.center,
          title: Center(child: Text('Choose Card To Payment')),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 21),
          
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: CustomBtn(
                buttonColor: Colors.amber,
                text: Text('OK'),
                height: 56,
                onTap: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
