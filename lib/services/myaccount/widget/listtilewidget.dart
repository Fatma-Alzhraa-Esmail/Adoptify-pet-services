import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ProfileOtherServices extends StatelessWidget {
  const ProfileOtherServices(
      {super.key,
      this.ontap,
      this.leading,
      this.trailing,
      required this.title});
  final Function()? ontap;
  final Widget? leading;
  final Widget? trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: ontap,
          leading: leading,
          title: Text(
            title,
            style: AppTextStyles.w500,
          ),
          trailing: trailing,
          horizontalTitleGap: 10,
        ),
        Divider(
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 0,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
