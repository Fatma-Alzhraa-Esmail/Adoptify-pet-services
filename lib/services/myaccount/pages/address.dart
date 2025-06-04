import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';

import 'package:peto_care/services/address/pages/add_address.dart';
import 'package:peto_care/utilities/theme/media.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Address',
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
              onTap: () {
                CustomNavigator.push(Routes.addNewAddress);
              },
              child: Icon(
                Icons.add,
                color: Colors.amber[600],
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                //  BlocProvider(
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
                //             width: MediaHelper.width,
                //             height: MediaHelper.height,
                //             // height: 86,
                //             child: ListView.separated(
                //                 separatorBuilder: (context, index) => SizedBox(height: 1,),
                //                 scrollDirection: Axis.vertical,
                //                 itemCount: cubit.addressInfo.length,
                //                 itemBuilder: (context, index) => Slidable(

                //                       endActionPane: ActionPane(
                //                           motion: const BehindMotion(),
                //                           extentRatio: .28,
                //                           children: [
                //                             SlidableAction(
                //                               onPressed: (context) {},
                //                               icon: Icons.edit,
                //                               foregroundColor:
                //                                   Colors.amber[600],
                //                               autoClose: true,
                //                             ),
                //                             SlidableAction(
                //                               onPressed: (context) {},
                //                               icon: Icons.delete_outlined,
                //                               foregroundColor:
                //                                   Colors.amber[600],
                //                             )
                //                           ]),
                //                       child: AddAddressWidget(
                //                           context, cubit.addressInfo[index]),
                //                     )),
                //           );
                       
                       
                       
                //         })),
             
             
              ],
            ),
          ))
        ],
      )),
    );
  }
}
