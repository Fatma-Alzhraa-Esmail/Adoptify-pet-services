import 'package:adoptify/services/register/logic/facebook_auth_cubit/facebook_auth_cubit.dart';
import 'package:adoptify/utilities/components/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacebookAuthWidget extends StatelessWidget {
  const FacebookAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FacebookAuthCubit(),
      child: BlocConsumer<FacebookAuthCubit, FacebookAuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var facebookAuthCubit = context.read<FacebookAuthCubit>();
          return SocialButton(
            onTap: () => facebookAuthCubit.signUpWithFacebook(),
            buttonColor: const Color.fromARGB(255, 2, 71, 128),
            height: 44,
            imagee: Image.asset(
              'assets/images/facebookpng-removebg-preview.png',
              fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
            text: 'Facebook',
          );
        },
      ),
    );
  }
}
