import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/base/models/user_model.dart';
import 'package:peto_care/core/validator.dart';
import 'package:peto_care/handlers/shared_handler.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/auth/Login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> with Validations {
  LoginCubit() : super(LoginIntialState());
  //=====================================================
  //===================================================== Variables
  //=====================================================
  bool formVaildate = false;
  bool isLoading = false;
  TextEditingController emailcontroller = TextEditingController();
  String emailError = '';
  bool emailIsValid = true;
  TextEditingController passwordcontroller = TextEditingController();
  String passwordError = '';
  bool passwordIsValid = true;

  //=====================================================
  //===================================================== Function
  //=====================================================

  bool validate() {
    emailError = isValidEmail(emailcontroller.text);
    passwordError = isValidPassword(passwordcontroller.text);
    emailIsValid = emailError.isEmpty;
    passwordIsValid = passwordError.isEmpty;
    return emailIsValid && passwordIsValid;
  }

  bool isEmpty() {
    var formIsEmpty =
        emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty;
    print(formIsEmpty);
    emit(LoginFormEmptyState(formEmpty: formIsEmpty));

    return formIsEmpty;
  }

  void click() {
    loginUser();
  }

  Future<void> loginUser() async {
    try {
      isLoading = true;
      if (validate()) {
        Map<String, dynamic> data = {
          "email": emailcontroller.text,
          "password": passwordcontroller.text
        };
        emit(LoginLoadingState());

        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);
        emit(LoginLoadingState());
      await  SharedHandler.instance!
            .setData(SharedKeys().user, value: user.user!.uid);


             DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Adjust to your collection name
          .doc(user.user!.uid)
          .get();
            await  SharedHandler.instance!
            .setData(SharedKeys().userData, value: userDoc.data()!);
        SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      
        CustomNavigator.push(
          Routes.Navigation,
        );

        emit(LoginSuccessState());
        isLoading = false;
      } else {
        emit(LoginFailureState(messageError: 'Please Verify Your account'));
      }
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      if (ex.code == 'user-not-found') {
        emailIsValid = false;
        emailError = 'No matching account found';
        print("//No matching account found///");
        emit(LoginFailureState(messageError: 'No matching account found'));
      } else if (ex.code.toUpperCase() == "WRONG-PASSWORD") {
        passwordIsValid = false;

        passwordError = "Incorrect password";
        emit(LoginFailureState(messageError: 'Incorrect password'));
      } else {
        print('Something went wrong With Email Or Password  $ex');
        emit(LoginFailureState(
            messageError: 'Something went wrong With Email Or Password'));
      }
    } catch (e) {
      print('There was an error please try again');
      emit(LoginFailureState(
          messageError: 'There was an error please try again'));
    }
  }
}
