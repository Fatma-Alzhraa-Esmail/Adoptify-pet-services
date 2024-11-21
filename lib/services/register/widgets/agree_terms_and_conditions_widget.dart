import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:flutter/material.dart';

class agreeTermsAndConditions extends StatelessWidget {
  const agreeTermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20, top: 20),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text.rich(
          TextSpan(
            text:
                'By clicking Sign up you agree to the following',
            style: TextStyle(fontSize: 14),
            children: [
              TextSpan(
                text: ' Terms \nand Codition',
                style:AppTextStyles.w500.copyWith(color: LightTheme().mainColor),
                
                 
              ),
              TextSpan(
                text: ' without reservation.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

