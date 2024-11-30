import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ContactWithTextWidget extends StatelessWidget {
  const ContactWithTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30, vertical: 30),
        child: GestureDetector(
          onTap: () {},
          child: Text(
            textAlign: TextAlign.right,
            'Contact with',
            style: AppTextStyles.w500
                .copyWith(color: LightTheme().greyTitle),
          ),
        ),
      ),
    );
  }
}
