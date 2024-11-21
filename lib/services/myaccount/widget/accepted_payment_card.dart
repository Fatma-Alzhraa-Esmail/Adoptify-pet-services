import 'package:flutter/material.dart';
import 'package:peto_care/services/myaccount/model/accepted_payment_card.dart';

Widget AcceptedPaymentCardWidget(
    BuildContext context, AcceptedPaymentCard acceptedPaymentCard) {
  return InkWell(
    onTap: acceptedPaymentCard.route,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Container(
        width: 66,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage('${acceptedPaymentCard.image}'),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1.4,
                offset: Offset(0, 2),
              ),
            ]),
        //  width: 120,
        height: 90,
      ),
    ),
  );
}
