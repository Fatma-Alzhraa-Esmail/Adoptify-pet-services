import 'package:adoptify/services/register/logic/email_auth_cubit/register_cubit.dart';
import 'package:adoptify/services/register/logic/email_auth_cubit/register_state.dart';

import 'package:adoptify/services/register/widgets/facebook_auth_widget.dart';
import 'package:adoptify/services/register/widgets/google_auth_widget.dart';
import 'package:adoptify/services/register/widgets/phone_field_widget.dart';
import 'package:adoptify/utilities/theme/colors/light_theme.dart';
import 'package:flutter/material.dart';

import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:adoptify/utilities/components/fields/text_input_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidden = true;
  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

//  TextEditingController phoneNumber = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is FormEmptyState) {
              var bloc = context.read<RegisterCubit>();

              bloc.formVaildate = state.formEmpty;
              print(bloc.formVaildate);
            }
          },
          builder: (context, state) {
            var bloc = context.read<RegisterCubit>();

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 40),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'USERNAME',
                                  hintText: 'Enter your name',
                                  controller: bloc.namecontroller,
                                  errorText: bloc.nameError,
                                  hasError: !bloc.nameIsValid,
                                  keyboardType: TextInputType.text,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.nameIsValid) {
                                      bloc.nameIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'EMAIL',
                                  hintText: 'Enter your Email',
                                  controller: bloc.emailcontroller,
                                  errorText: bloc.emailError,
                                  hasError: !bloc.emailIsValid,
                                  keyboardType: TextInputType.emailAddress,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.emailIsValid) {
                                      bloc.emailIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'PASSWORD',
                                  hintText: 'Enter your Password',
                                  controller: bloc.passwordcontroller,
                                  errorText: bloc.passwordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  hasError: !bloc.passwordIsValid,
                                  withBottomPadding: true,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.passwordIsValid) {
                                      bloc.passwordIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber phone) {
                                    print(phone);
                                    print(bloc.phonecontroller.text);
                                    print(bloc.initialCountry);
                                    bloc.phoneNumber = phone.phoneNumber!;
                                    bloc.initialCountry = phone.dialCode!;
                                    if (bloc.phoneNumber == phone.dialCode!) {
                                      bloc.phoneNumber = '';
                                    }
                                    bloc.isEmpty();

                                    // bloc.phoneValidate();
                                  },
                                  initialValue: number,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.408,
                                    height: 1.38,
                                  ),
                                  searchBoxDecoration: InputDecoration(
                                    hintText: "Search for country",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    counterStyle: TextStyle(
                                        color: Colors.transparent, fontSize: 16),
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      borderSide: BorderSide(
                                        color: Color(0xFFB9BBBC),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(70)),
                                      borderSide: BorderSide(
                                        color: Color(0xFFB9BBBC),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      borderSide: BorderSide(
                                        color: LightTheme().error,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  inputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    border: UnderlineInputBorder(),
                                    hintText: "Phone number",
                                    // errorText: bloc.phoneError,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    counterStyle: TextStyle(
                                        color: Colors.transparent, fontSize: 0),
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: LightTheme().error,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  selectorConfig: SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                      trailingSpace: false,
                                      leadingPadding: 0,
                                      useBottomSheetSafeArea: true,
                                      setSelectorButtonAsPrefixIcon: true),
                                  ignoreBlank: true,
                                  autoValidateMode: AutovalidateMode.always,
                                  selectorTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  textFieldController: bloc.phonecontroller,
                                  formatInput: true,
                                  onFieldSubmitted: (value) {
                                    bloc.initialCountry = value;
                                  },
                                  onInputValidated: (value) {
                                    print("value  $value");
                                    bloc.phoneIsValid = value;
                                    bloc.isEmpty();
                                  },
                                  onSaved: (value) {},
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  inputBorder: OutlineInputBorder(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text.rich(
                                    TextSpan(
                                      text:
                                          'By clicking Sign up you agree to the following',
                                      style: TextStyle(fontSize: 14),
                                      children: [
                                        TextSpan(
                                          text: ' Terms \nand Codition',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.amber,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' without reservation.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              phoneFieldWidget(bloc: bloc),
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    textAlign: TextAlign.right,
                                    'Contact with',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(child: GoogleAuthWidget()),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: FacebookAuthWidget())
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'You have account? ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      // decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      CustomNavigator.push(Routes.login);
                                    },
                                    child: Text(
                                      'Sign In ',
                                      style: TextStyle(
                                        color: Colors.amber[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        // decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

