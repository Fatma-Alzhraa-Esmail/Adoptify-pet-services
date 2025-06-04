import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.w500,
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style: AppTextStyles.w500,
        )
      ],
    );
  }
}
