
import 'package:flutter/material.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthStateInitial extends GoogleAuthState {}

final class GoogleAuthStateSuccess extends GoogleAuthState {}

final class GoogleAuthStateFailaure extends GoogleAuthState {
  final String error;
  GoogleAuthStateFailaure({required this.error});
}
final class GoogleAuthStateCancelled extends GoogleAuthState {
}
final class GoogleAuthLoading extends GoogleAuthState {
}
