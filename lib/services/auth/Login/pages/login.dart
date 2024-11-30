import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/services/auth/Login/cubit/login_cubit.dart';
import 'package:peto_care/services/auth/Login/cubit/login_state.dart';
import 'package:peto_care/services/auth/Login/widgets/contact_with_widget.dart';
import 'package:peto_care/services/auth/Login/widgets/donot_have_account.dart';
import 'package:peto_care/services/auth/Login/widgets/forget_password_text_widget.dart';
import 'package:peto_care/services/auth/Login/widgets/login_button_widget.dart';
import 'package:peto_care/services/auth/register/widgets/social_auth_body.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';
import 'package:peto_care/utilities/components/success_popup.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          var cubitLogin = context.read<LoginCubit>();
          if (state is LoginFormEmptyState) {
            cubitLogin.formVaildate = state.formEmpty;
            print(cubitLogin.formVaildate);
          } else if (state is LoginFormVaildateState) {
          } else if (state is LoginSuccessState) {
            // bloc.isLoading = true;
            showCustomDialog(context,
                headerTitle: 'Welcome back, ${UserModel.fromJson(SharedHandler.instance!.getData(key:SharedKeys().userData, valueType: ValueType.map)).name}',
                content:
                    'We\'re glad to see you again!');
          }
        },
        builder: (context, state) {
          var cubitLogin = context.read<LoginCubit>();
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 46,
                          ),
                          child: Text(
                            'Sign In',
                            style: AppTextStyles.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextInputField(
                            label: 'EMAIL',
                            hintText: 'Enter your Email',
                            controller: cubitLogin.emailcontroller,
                            errorText: cubitLogin.emailError,
                            hasError: !cubitLogin.emailIsValid,
                            keyboardType: TextInputType.emailAddress,
                            onChange: (p0) {
                              cubitLogin.isEmpty();
                              if (!cubitLogin.emailIsValid) {
                                cubitLogin.emailIsValid = true;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextInputField(
                            label: 'PASSWORD',
                            hintText: 'Enter your Password',
                            controller: cubitLogin.passwordcontroller,
                            errorText: cubitLogin.passwordError,
                            hasError: !cubitLogin.passwordIsValid,
                            keyboardType: TextInputType.visiblePassword,
                            onChange: (p0) {
                              cubitLogin.isEmpty();
                              if (!cubitLogin.passwordIsValid) {
                                cubitLogin.passwordIsValid = true;
                              }
                            },
                            //  suffixIcon:Icon( Icons.visibility),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ForgetPasswordTextWidget(),
                        LoginButtonWidget(cubitLogin: cubitLogin),
                        ContactWithTextWidget(),
                        SocialAuthBody(),
                        Expanded(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                        DonotHaveAccountWidget(),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}