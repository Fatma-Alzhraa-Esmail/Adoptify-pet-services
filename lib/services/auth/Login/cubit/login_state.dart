import 'package:flutter/material.dart';

@immutable
sealed class LoginState {}

class LoginIntialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String messageError;
  LoginFailureState({required this.messageError});
}

class LoginFormVaildateState extends LoginState {}

class LoginFormEmptyState extends LoginState {
  final bool formEmpty;
  LoginFormEmptyState({required this.formEmpty});
}
