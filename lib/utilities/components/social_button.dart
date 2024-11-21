import 'package:flutter/material.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

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
    this.textContent,
    this.onTap,
    this.imagee,
    this.isLoading=false
  });

  final double? height;
  final double? width;
  final double? radius;
  final Widget? text;
  final String? textContent;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? imagee;
  final bool isLoading;

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
              child: isLoading ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagee!,
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        textContent ?? "Click here",
                        style: AppTextStyles.w700.copyWith(
                            fontSize: 18, color: textColor ?? Colors.white),
                      ),
                    ],
                  ):CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                    strokeAlign: 1,
                    
                    
                  
                  
                    strokeCap: StrokeCap.round,
                  )),
    ));
  }
}
