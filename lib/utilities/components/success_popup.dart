import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context,
    { String? headerTitle,  String? content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetAnimationDuration: Duration(milliseconds: 1000),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              CircleAvatar(
                backgroundColor: LightTheme().mainColor.withOpacity(0.15),
                radius: 40,
                child:drawSvgIcon('success',iconColor:LightTheme().mainColor,height: 40,width: 40,) ,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                headerTitle ??'',
                style: AppTextStyles.w700.copyWith(fontSize: 22),
              ),
              SizedBox(height: 10.0),
              Text(
                content??'',
                textAlign: TextAlign.center,
                style: AppTextStyles.w500,
              ),
            ],
          ),
        ),
      );
    },
  );
}
