import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peto_care/services/myaccount/bloc/cubit.dart';
import 'package:peto_care/services/myaccount/bloc/state.dart';
import 'package:peto_care/services/myaccount/widget/add_address.dart';
import 'package:peto_care/utilities/theme/media.dart';

class DeliverToWidget extends StatefulWidget {
  const DeliverToWidget({super.key});

  @override
  State<DeliverToWidget> createState() => _DeliverToWidgetState();
}

class _DeliverToWidgetState extends State<DeliverToWidget> {
  TextEditingController shippingMethodController = TextEditingController(
    text: "(+\$5.5)",
  );
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocProvider(
              create: (BuildContext context) => CompleteProfileCubit(),
              child: BlocConsumer<CompleteProfileCubit,
                      CompleteProfileStates>(
                  listener:
                      (BuildContext context, CompleteProfileStates state) {},
                  builder:
                      (BuildContext context, CompleteProfileStates state) {
                    CompleteProfileCubit cubit =
                        CompleteProfileCubit.get(context);
                    return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1,
                            ),
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.addressInfo.length,
                        itemBuilder: (context, index) => Container(
                          width: MediaHelper.width,
                          child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    extentRatio: .28,
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {},
                                        icon: Icons.edit,
                                        foregroundColor: Colors.amber[600],
                                        autoClose: true,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {},
                                        icon: Icons.delete_outlined,
                                        foregroundColor: Colors.amber[600],
                                      )
                                    ]),
                                child: AddAddressWidget(
                                    context, cubit.addressInfo[index]),
                              ),
                        ));
                  })),
        ),
       
       
        Expanded(
          // flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   SizedBox(height: 10,),
                  Divider(
                    color: Colors.grey.shade400,
                    height: 2,
                    thickness: 1,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: shippingMethodController,
                      decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(right: 20),
                        prefixText: "Standard Shipping ",
                        prefixStyle:
                            TextStyle(fontWeight: FontWeight.w900, fontSize: 18,),
                        label: Text("SHIPPING METHOD"),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.grey.shade500),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                        
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          controller: noteController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding:
                                  
                                  EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Write a note",
                            
                              prefixStyle: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                  color: Colors.grey.shade500),
                              border: InputBorder.none,
                                  
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none,
                                  
                                  )),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
       
      ],
    );
  }
}
