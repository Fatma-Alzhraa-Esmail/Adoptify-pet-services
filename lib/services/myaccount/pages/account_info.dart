import 'package:flutter/material.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';

enum Gender {
  male,
  female,
  other,
}

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  TextEditingController UserNamecontroller =
      TextEditingController(text: 'Fatma Alzhraa');
  TextEditingController FullNamecontroller =
      TextEditingController(text: 'Fatma Alzhraa Esmail');
  TextEditingController Emailcontroller =
      TextEditingController(text: 'fatmaalzhraazedan@gmail.com');
  TextEditingController Gendercontroller =
      TextEditingController(text: 'Female');
  // TextEditingController _genderController = TextEditingController();

  TextEditingController PhoneNumbercontroller =
      TextEditingController(text: '01065576124');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Account Info',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('assets/images/person.jpeg'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Change avatar',
                      style: TextStyle(
                          color: Colors.amber[500],
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                        label: 'USERNAME',
                        hintText: 'Enter your name',
                        controller: UserNamecontroller,
                        errorText: 'please enter ur name',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
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
                        label: 'EMAIL',
                        hintText: 'Enter your Email',
                        controller: Emailcontroller,
                        errorText: 'please enter ur email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                        label: 'GENDER',
                        hintText: 'Enter your gender',
                        controller: Gendercontroller,
                        errorText: 'please enter ur gender',
                        // onTap: () {
                        //   print('object');
                        //   showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         title: Text('Select Gender'),
                        //         content: Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             ListTile(
                        //               title: Text('Male'),
                        //               onTap: () {
                        //                 _genderController.text = Gender.male
                        //                     .toString()
                        //                     .split('.')
                        //                     .last;
                        //                 Navigator.pop(context);
                        //               },
                        //             ),
                        //             ListTile(
                        //               title: Text('Female'),
                        //               onTap: () {
                        //                 _genderController.text = Gender.female
                        //                     .toString()
                        //                     .split('.')
                        //                     .last;
                        //                 Navigator.pop(context);
                        //               },
                        //             ),
                        //             ListTile(
                        //               title: Text('Other'),
                        //               onTap: () {
                        //                 _genderController.text = Gender.other
                        //                     .toString()
                        //                     .split('.')
                        //                     .last;
                        //                 Navigator.pop(context);
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   );
                        // },
                      ),
                    ),
              
              //                    TextFormField(
              //   controller: _genderController,
              //   decoration: InputDecoration(
              //     labelText: 'Gender',
              //   ),
              //   onTap: () {
              //     // Show a dialog or navigate to a page with options to select gender
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: Text('Select Gender'),
              //           content: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               ListTile(
              //                 title: Text('Male'),
              //                 onTap: () {
              //                   _genderController.text = Gender.male.toString().split('.').last;
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //               ListTile(
              //                 title: Text('Female'),
              //                 onTap: () {
              //                   _genderController.text = Gender.female.toString().split('.').last;
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //               ListTile(
              //                 title: Text('Other'),
              //                 onTap: () {
              //                   _genderController.text = Gender.other.toString().split('.').last;
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
              
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
                  ],
                ),
              ),
            ),
            //  Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomBtn(
                height: 50,
                text: Text('SAVE'),
                buttonColor: Colors.amber[600],
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
