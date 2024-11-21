part of 'facebook_auth_cubit.dart';

@immutable
sealed class FacebookAuthState {}

final class FacebookAuthInitial extends FacebookAuthState {}
final class FacebookAuthStateInitial extends FacebookAuthState {}

final class FacebookAuthSuccess extends FacebookAuthState {}

final class FacebookAuthStateFailaure extends FacebookAuthState {
  final String error;
  FacebookAuthStateFailaure({required this.error});
}
final class FacebookAuthStateCancelled extends FacebookAuthState {
}
final class FacebookAuthLoading extends FacebookAuthState {
}