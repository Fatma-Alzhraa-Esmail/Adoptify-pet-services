import 'package:flutter/material.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/utilities/components/custom_btn.dart';
import 'package:adoptify/utilities/components/fields/text_input_field.dart';

// ignore: must_be_immutable
class AddNewAddress extends StatelessWidget {
  TextEditingController FullNamecontroller =
      TextEditingController(text: 'Fatma Alzhraa Esmail');
  TextEditingController AddressController =
      TextEditingController(text: 'Fatma 18-123 Latona ave NE');

  TextEditingController PhoneNumbercontroller =
      TextEditingController(text: '01065576124');
  TextEditingController Citycontroller =
      TextEditingController(text: 'Washington');
  TextEditingController Countrycontroller =
      TextEditingController(text: 'United States');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'New Address',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    controller: FullNamecontroller,
                    errorText: 'please enter ur full name',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    label: 'ADDRESS',
                    hintText: 'Enter your address',
                    controller: AddressController,
                    errorText: 'please enter ur address',
                    keyboardType: TextInputType.streetAddress,
                    suffixIcon: Icon(
                      Icons.room_outlined,
                      size: 26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    label: 'PHONE NUMBER',
                    hintText: 'Enter your phone',
                    controller: PhoneNumbercontroller,
                    errorText: 'please enter ur phone',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    label: 'CITY',
                    hintText: 'Enter your city',
                    controller: Citycontroller,
                    errorText: 'please enter ur city',
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    label: 'COUNTRY',
                    hintText: 'Enter your country',
                    controller: Countrycontroller,
                    errorText: 'please enter ur country',
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomBtn(
              height: 50,
              text: Text('SAVE'),
              buttonColor: Colors.amber[600],
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      )),
    );
  }
}
