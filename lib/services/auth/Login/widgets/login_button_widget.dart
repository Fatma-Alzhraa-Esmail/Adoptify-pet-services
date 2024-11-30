import 'package:flutter/material.dart';
import 'package:peto_care/services/auth/Login/cubit/login_cubit.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.cubitLogin,
  });

  final LoginCubit cubitLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: CustomBtn(
          isFeedback: !cubitLogin.formVaildate ? false : true,
          text: cubitLogin.isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                )
              : Text(
                  'SIGN IN',
                  style: AppTextStyles.w600.copyWith(color: Colors.white),
                ),
          buttonColor: !cubitLogin.formVaildate
              ? Colors.amber.withOpacity(0.4)
              : Colors.amber,
          borderColor: !cubitLogin.formVaildate
              ? Colors.amber.withOpacity(0.4)
              : Colors.amber,
          height: 44,
          onTap: () {
            if (!cubitLogin.formVaildate) {
            } else {
              cubitLogin.click();
            }
          },
        ),
      ),
    );
  }
}
