import 'package:flutter/material.dart';
import 'package:peto_care/handlers/icon_handler.dart';

class ConfirmedWidget extends StatefulWidget {
  const ConfirmedWidget({super.key});

  @override
  State<ConfirmedWidget> createState() => _ConfirmedWidgetState();
}

class _ConfirmedWidgetState extends State<ConfirmedWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        drawSvgIcon("confirm",width: 100,height: 100,iconColor: Colors.amber),
        SizedBox(height: 30,),
        Text("Order Confirmed",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),),
                SizedBox(height: 5,),

        Text("Estimated delivery time",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey.shade500),)
      ],
    ));
  }
}