import 'package:flutter/material.dart';
import 'package:adoptify/utilities/theme/media.dart';
import 'package:adoptify/utilities/theme/text_styles.dart';

import '../../base/blocs/theme_bloc.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(      {super.key,
      this.height,
      this.width,
      this.radius,
      this.text,
      this.buttonColor,
      this.textColor,
      this.onTap,
      this.borderColor,this.textContent,
      this.isFeedback,
      });

  final double? height;
  final double? width;
  final double? radius;
  final Widget? text;
  final String? textContent;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final bool? isFeedback;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap:isFeedback??true ? onTap:null,
      // enableFeedback:isFeedback??true ?true: false,
      // splashColor:isFeedback ??true ?null: Colors.transparent,
      // highlightColor: isFeedback ??true ?null: Colors.transparent,

      child: Container(
        width: width ?? MediaHelper.width,
        height: height ?? 56,

        decoration: BoxDecoration(
          color: buttonColor ?? themeBloc.theme.valueOrNull!.primary,
          borderRadius: BorderRadius.circular(radius ?? 8),
          border: Border.all(color: borderColor ?? Colors.amber)
        ),
        child: Center(
          child:text?? Text(
             "Clicke here",
            style: AppTextStyles.w700
                .copyWith(fontSize: 22, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
