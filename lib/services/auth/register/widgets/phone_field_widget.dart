import 'package:peto_care/services/auth/register/cubit/email_auth_cubit/register_cubit.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget({
    super.key,
    required this.bloc,
    required this.number,
  });

  final RegisterCubit bloc;
  final PhoneNumber number;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
