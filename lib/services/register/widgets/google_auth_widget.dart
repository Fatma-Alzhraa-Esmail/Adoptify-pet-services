import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/services/register/logic/google_auth_cubit/google_auth_cubit.dart';
import 'package:peto_care/services/register/logic/google_auth_cubit/google_auth_state.dart';
import 'package:peto_care/utilities/components/social_button.dart';
import 'package:peto_care/utilities/components/success_popup.dart';
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
        listener: (context, state) {
          if (state is GoogleAuthLoading){}
          else if(state is GoogleAuthStateFailaure){


          }
          else if(state is GoogleAuthStateSuccess){
                        showCustomDialog(context);

          }
        },
        builder: (context, state) {
          var googleAuthCubit = context.read<GoogleAuthCubit>();

          return  SocialButton(
            onTap: () => googleAuthCubit.signUpWithGoogle(),
            buttonColor: Colors.red,
            height: 44,
            imagee: Image.asset(
              Assets.assetsImagesGoogleRemovebgPreview1,
              fit: BoxFit.cover,
              width: 45,
              height: 45,
            ),
            textContent:"Google" ,
            isLoading: !googleAuthCubit.isLoading,
            text: Text('Google') ,
          );
        },
      ),
    );
  }
}
