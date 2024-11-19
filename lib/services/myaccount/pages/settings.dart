import 'package:adoptify/services/register/logic/email_auth_cubit/register_cubit.dart';
import 'package:adoptify/services/register/logic/email_auth_cubit/register_state.dart';
import 'package:adoptify/services/register/logic/google_auth_cubit/google_auth_cubit.dart';
import 'package:adoptify/services/register/logic/google_auth_cubit/google_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/services/myaccount/widget/listtilewidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          ProfileOtherServices(
            leading: Icon(Icons.security_outlined),
            trailing: Icon(Icons.arrow_forward_ios),
            title: 'Security',
          ),
          ProfileOtherServices(
            leading: Icon(Icons.notifications_outlined),
            trailing: Icon(Icons.arrow_forward_ios),
            title: 'Notification',
          ),
          ProfileOtherServices(
            leading: Icon(Icons.translate_outlined),
            trailing: Icon(Icons.arrow_forward_ios),
            // trailing: Icon(Icons.fmd_good),
            title: 'Langauge',
          ),
          ProfileOtherServices(
            leading: Icon(Icons.contact_mail),
            trailing: Icon(Icons.arrow_forward_ios),
            title: 'Connect',
          ),
          BlocProvider(
            create: (context) => GoogleAuthCubit(),
            child: BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                var logoutCubit = context.read<GoogleAuthCubit>();
                return ProfileOtherServices(
                  ontap: () {
                    logoutCubit.signOut();
                  },
                  leading: Icon(Icons.logout),
                  title: 'Logout',
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
