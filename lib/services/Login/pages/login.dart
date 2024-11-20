import 'package:flutter/material.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:adoptify/utilities/components/custom_btn.dart';
import 'package:adoptify/utilities/components/fields/text_input_field.dart';
import 'package:adoptify/utilities/components/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordontroller = TextEditingController();

  bool isHidden = true;
  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 64,
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      label: 'EMAIL',
                      hintText: 'Enter your Email',
                      controller: namecontroller,
                      errorText: 'please enter correct Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInputField(
                      label: 'PASSWORD',
                      hintText: 'Enter your Password',
                      controller: passwordontroller,
                      errorText: 'Wrong password',
                      keyboardType: TextInputType.visiblePassword,
                      //  suffixIcon:Icon( Icons.visibility),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          textAlign: TextAlign.right,
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 36),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomBtn(
                        buttonColor: Colors.amber,
                        height: 50,
                        onTap: () {},
                        text: Text('Sign In'),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          textAlign: TextAlign.right,
                          'Contact with',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: SocialButton(
                            buttonColor: Colors.red,
                            height: 50,
                            imagee: Image.asset(
                              'assets/images/google-removebg-preview (1).png',
                              fit: BoxFit.cover,
                              width: 45,
                              height: 45,
                            ),
                            text: Text('Google'),
                          )),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: SocialButton(
                            buttonColor: const Color.fromARGB(255, 2, 71, 128),
                            height: 50,
                            imagee: Image.asset(
                              'assets/images/facebookpng-removebg-preview.png',
                              fit: BoxFit.cover,
                              width: 30,
                              height: 30,
                            ),
                            text: Text('Facebook'),
                          ))
                        ],
                      ),
                    ),
                  ),
                 SizedBox(height: 20,)
                 
                ],
              ),
            )),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              Text(
                'You don\'t have account? ',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  // decoration: TextDecoration.underline,
                ),
              ),
              GestureDetector(
                onTap: () {
                  CustomNavigator.push(Routes.register);
                },
                child: Text(
                  'Sign Up ',
                  style: TextStyle(
                    color: Colors.amber[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ]),
                      SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
