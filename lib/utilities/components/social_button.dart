import 'package:flutter/material.dart';
import 'package:adoptify/utilities/theme/colors/colors.dart';
import 'package:adoptify/utilities/theme/media.dart';
import 'package:adoptify/utilities/theme/text_styles.dart';

import '../../base/blocs/theme_bloc.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.text,
    this.buttonColor,
    this.textColor,
    this.onTap, this.imagee,
  });

  final double? height;
  final double? width;
  final double? radius;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? imagee;
  
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaHelper.width,
        height: height ?? 56,
        decoration: BoxDecoration(
          color: buttonColor ?? themeBloc.theme.valueOrNull!.primary,
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           imagee!,
              SizedBox(width: 3,),
              Text(
                text ?? "Clicke here",
                style: AppTextStyles.w700.copyWith(fontSize: 18, color: textColor ?? Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
