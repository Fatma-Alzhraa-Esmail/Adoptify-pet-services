import 'package:flutter/material.dart';

@immutable
sealed class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterStart extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}
// ignore: must_be_immutable
class RegisterFailure extends RegisterState {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}

// ignore: must_be_immutable
class PhoneVaildatestate extends RegisterState {
  PhoneVaildatestate();
}
// ignore: must_be_immutable
class FormEmptyState extends RegisterState {
  bool formEmpty;
  FormEmptyState({required this.formEmpty});
}
// ignore: must_be_immutable
class FormValidateState extends RegisterState {
  String formValidate;
  FormValidateState({required this.formValidate});
}