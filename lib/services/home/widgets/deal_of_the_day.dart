import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peto_care/services/home/model/deal_of_the_day.dart';


Widget DealOfTheDayWidget(BuildContext context, DealOfTheDay dealOfTheDay) {
  DateTime offerEndTime = DateTime.now().add(Duration(hours: dealOfTheDay.timer.toInt() ));

  return Padding(
    padding: const EdgeInsets.only(left: 15,bottom: 8,right: 15),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow:[
          BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
        ]
      ),
      //  width: 185,
      height: 100,
      child: Row(     
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
            width: 75,
            height: 75,
            child: Image.asset('${dealOfTheDay.image}',fit: BoxFit.cover,),),
          ),
          SizedBox(width: 25,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text('${dealOfTheDay.title}',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
        Row(

          children: [
            Text('\$${dealOfTheDay.new_price}',style: TextStyle(color:Color.fromARGB(255, 222, 174, 31),fontWeight: FontWeight.w700,fontSize: 15 ),),
            SizedBox(width: 8,),
            Text('\$${dealOfTheDay.price}',style: TextStyle(color:Colors.grey.shade600,fontWeight: FontWeight.w500 ,fontSize: 15,decoration: TextDecoration.lineThrough ),),
          ],
        ),
        // Text('End in ${dealOfTheDay.timer}'),
        OfferTimer(offerEndTime: offerEndTime),


          ],
        )
        ],
      ),
    ),
  );
}
class OfferTimer extends StatefulWidget {
  final DateTime offerEndTime;

   const OfferTimer({required this.offerEndTime});

  @override
  _OfferTimerState createState() => _OfferTimerState();
}

class _OfferTimerState extends State<OfferTimer> {
  late Timer _timer;
  late Duration _timeRemaining;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.offerEndTime.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining = widget.offerEndTime.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'End in ${_formatDuration(_timeRemaining)}',
      style: TextStyle(fontSize: 16, color: Colors.grey.shade500,fontWeight: FontWeight.w500),
    );
  }
}
