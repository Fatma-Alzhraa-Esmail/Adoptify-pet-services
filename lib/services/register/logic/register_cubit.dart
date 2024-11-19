import 'package:adoptify/base/models/user_model.dart';
import 'package:adoptify/core/validator.dart';
import 'package:adoptify/handlers/shared_handler.dart';
import 'package:adoptify/routers/navigator.dart';
import 'package:adoptify/routers/routers.dart';
import 'package:adoptify/services/register/logic/email_auth_cubit/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterCubit extends Cubit<RegisterState> with Validations {
  RegisterCubit() : super(RegisterInitial());

  //=====================================================

  //===================================================== Variables

  //=====================================================
  bool formVaildate = false;
  bool isLoading = false;
  TextEditingController namecontroller = TextEditingController();

  String nameError = '';

  bool nameIsValid = true;

  TextEditingController emailcontroller = TextEditingController();

  String emailError = '';

  bool emailIsValid = true;

  TextEditingController passwordcontroller = TextEditingController();

  String passwordError = '';

  bool passwordIsValid = true;

  TextEditingController phonecontroller = TextEditingController();

  String phoneError = '';

  bool phoneIsValid = true;
  String initialCountry = 'EG';
  String phoneNumber = '';

  UserModel? usermodel;

  // bool emailValidate() {
  //   emailError = isValidEmail(emailcontroller.text);
  //   emailIsValid = emailError.isEmpty;
  //   emit(EmailVaildatestate(emailValidate: emailIsValid));
  //   return emailIsValid;
  // }

//   bool phoneValidate() {
//     // if (phoneIsValid) {
//     //   print("phoneIsValidate ${phoneIsValid}");
//     //   emit(PhoneVaildatestate());
//     // }
//  print("phoneIsValidate ${phoneIsValid}");
//     return phoneIsValid;
//   }

  bool isEmpty() {
    var formIsEmpty = namecontroller.text.isNotEmpty &&
        emailcontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        initialCountry.isNotEmpty &&
        phoneIsValid;
    print("maklSamdx,aS");
    print(formIsEmpty);
    emit(FormEmptyState(formEmpty: formIsEmpty));

    return formIsEmpty;
  }

  bool validate() {
    nameError = isValidName(namecontroller.text);
    emailError = isValidEmail(emailcontroller.text);
    passwordError = isValidPassword(passwordcontroller.text);

    // phoneError = isValidPhone(phoneNumber+initialCountry);

    nameIsValid = nameError.isEmpty;

    emailIsValid = emailError.isEmpty;

    passwordIsValid = passwordError.isEmpty;

    bool formValidate =
        nameIsValid && emailIsValid && passwordIsValid && phoneIsValid;
    print("lmkcsdcfndsz");
    print(formValidate);
    return formValidate;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void click() {
    userRegister();
  }

  Future<void> userRegister() async {
    print(validate());
    try {
      isLoading = true;
      if (validate()) {
        emit(RegisterLoading());

        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text);

        usermodel = UserModel(
          name: namecontroller.text,
          phone: phonecontroller.text,
          email: emailcontroller.text,
          image: '',
        );
        storeDatabaseFirestore(user.user!.uid.toString()).then((value) {
          print("stored Success");
          SharedHandler.instance!
              .setData(SharedKeys().user, value: user.user!.uid);

          //  SharedHandler.instance!.setData(SharedKeys().user, value: data);
          SharedHandler.instance!.setData(SharedKeys().isRegister, value: true);
          CustomNavigator.push(Routes.login);
        });

        emit(RegisterSuccess());
        isLoading = false;
      } else {
        isLoading = false;
        emit(FormValidateState(formValidate: 'validation Error'));
      }
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      if (ex.code.toUpperCase() == 'WEAK-PASSWORD') {
        passwordIsValid = false;
        passwordError = "Weak password";
        emit(RegisterFailure(errorMessage: passwordError));
      } else if (ex.code.toUpperCase() == "EMAIL-ALREADY-IN-USE") {
        emailIsValid = false;
        emailError = "User is found";
        emit(RegisterFailure(errorMessage: emailError));
      } else if (ex.code == 'wrong-password') {
        passwordIsValid = false;

        passwordError = "Incorrect password";
        emit(RegisterFailure(errorMessage: passwordError));
      }
    } catch (e) {
      isLoading = false;
      emit(
          RegisterFailure(errorMessage: 'There was an error please try again'));
    }
  }

  Future storeDatabaseFirestore(String id) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(usermodel!.toJson());
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
