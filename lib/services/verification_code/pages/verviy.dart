import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';

class VerifyPhoneScreen extends StatefulWidget {
  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic phoneNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            CustomNavigator.pop(result: VerifyPhoneScreen());
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
        ),
        elevation: 0.0,
        title: Text(
          'Verify Phone Number',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(children: [
          Text(
            'We have sent you an SMS with a code to number \n+08 905 070 017',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.black54),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 2,
            child: IntlPhoneField(
              controller: phonecontroller,
              cursorColor: Colors.amber,
              autofocus: true,
              dropdownIcon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),

              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

                //  border: Border.all(color: Colors.grey.shade500)
              ),
              dropdownTextStyle: TextStyle(color: Colors.black),
              dropdownIconPosition: IconPosition.trailing,
              decoration: InputDecoration(
                suffixIcon: phonecontroller.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black38,
                        ),
                      ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              initialCountryCode: phoneNumber?.isoCode ?? 'US',
              pickerDialogStyle: PickerDialogStyle(
                countryNameStyle: TextStyle(color: Colors.black),
                countryCodeStyle: TextStyle(color: Colors.black),
                searchFieldCursorColor: Colors.black,
                searchFieldInputDecoration: InputDecoration(
                  // fillColor: Colors.black,
                  suffixIcon: Icon(Icons.search,color: Colors.black,),
                  label: Text('Search Country',style: TextStyle(color: Colors.black),),
                  
                  iconColor: Colors.black
                )

              ),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
          ),
          CustomBtn(
            buttonColor: Colors.amber[600],
            onTap: () {
              CustomNavigator.push(Routes.phone);
            },
            text: Text('CONFIRM'),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       fixedSize: Size(100, 47),

          //       primary:
          //           Colors.amber[600], // change the background color
          //       onPrimary: Colors.white, // change the text color
          //     ),
          //     onPressed: () {
          //       CustomNavigator.push(Routes.phone);
          //     },
          //     child: Text(
          //       'CONFIRM',
          //       style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
