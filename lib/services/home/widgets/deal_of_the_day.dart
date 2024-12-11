import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/services/home/model/product_model.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class DealOFTheDayWidget extends StatefulWidget {
  const DealOFTheDayWidget({
    required this.productItem,
    super.key,
  });
  final ProductModel productItem;

  @override
  State<DealOFTheDayWidget> createState() => _DealOFTheDayWidgetState();
}

class _DealOFTheDayWidgetState extends State<DealOFTheDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 8, right: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
            ]),
        //  width: 185,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(-6, -8),
                  child: Stack(
                    children: [
                      drawSvgIcon(
                        'label',
                        iconColor: HexColor('#18d0ce'),
                        height: 60,
                        width: 60,
                      ),
                      Positioned(
                          left: 14,
                          top: 21,
                          child: Text('${widget.productItem.discount}%',style: AppTextStyles.w500.copyWith(color: Colors.white,fontSize: 15),)),
                    ],
                  ),
                ),
                Transform.translate(
                   offset: Offset(0, -16),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CachedNetworkImage(
                       imageUrl: widget.productItem.colors![0].images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.productItem.product_name}',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      '\$${widget.productItem.price! * widget.productItem.discount! / 100}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 222, 174, 31),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '\$${widget.productItem.price}',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                // Text('End in ${dealOfTheDay.timer}'),
                OfferTimer(offerEndTime: widget.productItem.offer_end_date!),
              ],
            )
          ],
        ),
      ),
    );
  }
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
      style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500),
    );
  }
}
