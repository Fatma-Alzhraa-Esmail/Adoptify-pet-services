import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context) {
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
             Icon(Icons.check_circle,color: LightTheme().mainColor,size: 48,),
             SizedBox(height: 16,),
             Text(
                'Congratulations!',
                style: AppTextStyles.w600,
              ),
              SizedBox(height: 12.0),
              Text(
                'Your account is ready to use, you will be redirected to the Home page in s few seconds.',
                textAlign: TextAlign.center,
                style: AppTextStyles.w600,
              ),
              
            ],
          ),
        ),
      );
    },
  );
}