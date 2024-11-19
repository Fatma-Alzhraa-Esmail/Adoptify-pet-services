import 'package:flutter/material.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:pinput/pinput.dart';

class phone extends StatefulWidget {
  const phone({super.key});

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Phone verification",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          // alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your OTP code here",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  // defaultPinTheme: defaultPinTheme,
                  // focusedPinTheme: focusedPinTheme,
                  // submittedPinTheme: submittedPinTheme,

                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        CustomNavigator.push(Routes.Navigation);
                      },
                      child: Text(
                        "Verify Phone Number",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Didn'\t you recieved any code?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Click Resend",
                  style: TextStyle(
                    color: Colors.amber[600],
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
