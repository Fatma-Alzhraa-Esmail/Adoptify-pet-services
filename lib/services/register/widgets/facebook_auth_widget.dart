import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/services/register/logic/facebook_auth_cubit/facebook_auth_cubit.dart';
import 'package:peto_care/utilities/components/social_button.dart';
import 'package:peto_care/utilities/components/success_popup.dart';
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
        listener: (context, state) {
          if (state is FacebookAuthSuccess) {
            showCustomDialog(context);
          }
        },
        builder: (context, state) {
          var facebookAuthCubit = context.read<FacebookAuthCubit>();
          return SocialButton(
            onTap: () => facebookAuthCubit.signUpWithFacebook(),
            buttonColor: const Color.fromARGB(255, 2, 71, 128),
            height: 44,
            imagee: Image.asset(
              Assets.assetsImagesFacebookpngRemovebgPreview,
              fit: BoxFit.cover,
              width: 28,
              height: 28,
            ),
            textContent: 'Facebook',
            text: Text('Facebook'),
            isLoading: !facebookAuthCubit.isLoading,
          );
        },
      ),
    );
  }
}
