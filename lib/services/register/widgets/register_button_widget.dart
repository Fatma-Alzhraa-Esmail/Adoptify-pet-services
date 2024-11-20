import 'package:adoptify/services/register/logic/email_auth_cubit/register_cubit.dart';
import 'package:adoptify/services/register/logic/email_auth_cubit/register_state.dart';
import 'package:adoptify/utilities/components/custom_btn.dart';
import 'package:adoptify/utilities/components/success_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({
    super.key,
    required this.bloc,
  });

  final RegisterCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is FormEmptyState) {
            bloc.formVaildate = state.formEmpty;
            print(bloc.formVaildate);
          } else if (state is FormValidateState) {
            print(state.formValidate);
          } else if (state is RegisterSuccess) {
            // bloc.isLoading = true;
            showCustomDialog(context);
          } else if (state is RegisterFailure) {
            if (state.errorMessage == "User is found") {
              bloc.emailError = "User is found";
            }
          }
        },
        builder: (context, state) {
          return CustomBtn(
            isFeedback: !bloc.formVaildate ? false : true,
            text: bloc.isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6,
                    strokeCap: StrokeCap.round,
                  )
                : Text('Sign Up'),
            buttonColor: !bloc.formVaildate
                ? Colors.amber.withOpacity(0.4)
                : Colors.amber,
            borderColor: !bloc.formVaildate
                ? Colors.amber.withOpacity(0.4)
                : Colors.amber,
            height: 44,
            onTap: () {
              if (!bloc.formVaildate) {
              } else {
                bloc.click();
              }
            },
          );
        },
      ),
    );
  }
}
