import 'package:flutter/material.dart';
import 'package:adoptify/services/home/model/services.dart';

Widget MainFeaturesWidget(BuildContext context, Services service) {
  return GestureDetector(
    onTap: service.route,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
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
        width: 185,
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 40,
              child: Image.asset(
                '${service.image}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '${service.ServicesName}',
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ),
  );
}
