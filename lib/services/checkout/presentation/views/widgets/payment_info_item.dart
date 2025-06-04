import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class PaymentItemInfo extends StatelessWidget {
  const PaymentItemInfo({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.w800,
        ),
        Text(
          value,
          style: AppTextStyles.w800,
        )
      ],
    );
  }
}
