import 'package:peto_care/services/register/logic/email_auth_cubit/register_cubit.dart';
import 'package:peto_care/services/register/logic/email_auth_cubit/register_state.dart';
import 'package:peto_care/services/register/widgets/agree_terms_and_conditions_widget.dart';
import 'package:peto_care/services/register/widgets/have_acount_widget.dart';
import 'package:peto_care/services/register/widgets/phone_field_widget.dart';
import 'package:peto_care/services/register/widgets/register_button_widget.dart';
import 'package:peto_care/services/register/widgets/social_auth_body.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is FormEmptyState) {
              var bloc = context.read<RegisterCubit>();
              bloc.formVaildate = state.formEmpty;
              print(bloc.formVaildate);
            }
          },
          builder: (context, state) {
            var bloc = context.read<RegisterCubit>();
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 46),
                                child: Text(
                                  'Sign Up',
                                  style: AppTextStyles.w700,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'USERNAME',
                                  hintText: 'Enter your name',
                                  controller: bloc.namecontroller,
                                  errorText: bloc.nameError,
                                  hasError: !bloc.nameIsValid,
                                  keyboardType: TextInputType.text,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.nameIsValid) {
                                      bloc.nameIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'EMAIL',
                                  hintText: 'Enter your Email',
                                  controller: bloc.emailcontroller,
                                  errorText: bloc.emailError,
                                  hasError: !bloc.emailIsValid,
                                  keyboardType: TextInputType.emailAddress,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.emailIsValid) {
                                      bloc.emailIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextInputField(
                                  label: 'PASSWORD',
                                  hintText: 'Enter your Password',
                                  controller: bloc.passwordcontroller,
                                  errorText: bloc.passwordError,
                                  keyboardType: TextInputType.visiblePassword,
                                  hasError: !bloc.passwordIsValid,
                                  withBottomPadding: true,
                                  onChange: (p0) {
                                    bloc.isEmpty();
                                    if (!bloc.passwordIsValid) {
                                      bloc.passwordIsValid = true;
                                    }
                                  },
                                ),
                              ),
                              PhoneFieldWidget(bloc: bloc, number: bloc.number),
                              
                              
                              agreeTermsAndConditions(),
                              
                              RegisterButtonWidget(bloc: bloc),
                              Container(
                                padding: EdgeInsets.only(bottom: 24),
                                alignment: Alignment.center,
                                child: Text(
                                  'Contact with',
                                  style: AppTextStyles.w500.copyWith(color: LightTheme().greyTitle),
                                  
                                ),
                              ),
                             
                              SocialAuthBody(),
                             
                              HaveAccountWidget(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


