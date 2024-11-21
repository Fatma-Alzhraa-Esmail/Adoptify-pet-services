import 'package:flutter/material.dart';
import 'package:peto_care/services/myaccount/model/complete_profile.dart';

Widget CompleteProfileWidget(
    BuildContext context, CompleteProfile completeProfile) {
  return GestureDetector(
    onTap: completeProfile.route,
    child: Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
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
        //  width: 120,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Image.asset(
              '${completeProfile.image}',
              fit: BoxFit.contain,
            )),
            Text(
              '${completeProfile.CompleteProfileName}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
