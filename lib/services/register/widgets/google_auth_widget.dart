import 'package:adoptify/services/register/logic/google_auth_cubit/google_auth_cubit.dart';
import 'package:adoptify/services/register/logic/google_auth_cubit/google_auth_state.dart';
import 'package:adoptify/utilities/components/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleAuthCubit(),
      child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var googleAuthCubit = context.read<GoogleAuthCubit>();

          return SocialButton(
            onTap: () => googleAuthCubit.signUpWithGoogle(),
            buttonColor: Colors.red,
            height: 44,
            imagee: Image.asset(
              'assets/images/google-removebg-preview (1).png',
              fit: BoxFit.cover,
              width: 45,
              height: 45,
            ),
            text: 'Google',
          );
        },
      ),
    );
  }
}
