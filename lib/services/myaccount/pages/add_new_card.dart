import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/services/myaccount/widget/accepted_payment_card.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  TextEditingController HolderNameController =
      TextEditingController(text: 'Fatma Alzhraa');
  TextEditingController CardNumberController =
      TextEditingController(text: '**** ***** 3063');
  TextEditingController ExperDateController =
      TextEditingController(text: '10/20');
  TextEditingController CvcController = TextEditingController(text: '368');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Add New Card',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(Icons.qr_code_scanner_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: Text(
                    'Accepted cards',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                  ),
                ),
                // BlocProvider(
                //     create: (BuildContext context) => CompleteProfileCubit(),
                //     child: BlocConsumer<CompleteProfileCubit,
                //             CompleteProfileStates>(
                //         listener: (BuildContext context,
                //             CompleteProfileStates state) {},
                //         builder: (BuildContext context,
                //             CompleteProfileStates state) {
                //           CompleteProfileCubit cubit =
                //               CompleteProfileCubit.get(context);
                //           return Container(
                //             width: MediaQuery.of(context).size.width,
                //             height: 86,
                //             child: ListView.builder(
                //                 // itemExtent: 130,
                //                 scrollDirection: Axis.horizontal,
                //                 itemCount: cubit.acceptedPaymentCard.length,
                //                 itemBuilder: (context, index) =>
                //                     AcceptedPaymentCardWidget(context,
                //                         cubit.acceptedPaymentCard[index])),
                //           );
                //         })),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 10, bottom: 4),
                  child: Text(
                    'Card information',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextInputField(
                    label: 'HOLDER Name',
                    controller: HolderNameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextInputField(
                    label: 'CARD NUMBER',
                    controller: CardNumberController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputField(
                          label: 'EXPER DATE',
                          controller: ExperDateController,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: TextInputField(
                          label: 'CVC',
                          controller: CvcController,
                        ),
                      ),
                    ],
                  ),
                )
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
