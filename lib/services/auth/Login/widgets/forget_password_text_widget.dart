import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ForgetPasswordTextWidget extends StatelessWidget {
  const ForgetPasswordTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: () {},
          child: Text(
            textAlign: TextAlign.right,
            'Forgot password?',
            style: AppTextStyles.w700.copyWith(
              color:Colors.grey.shade500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
