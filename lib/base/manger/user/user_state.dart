part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserError extends UserState {
  final String errMessage;

  UserError({required this.errMessage});
}

final class UserLoaded extends UserState {
  final UserModel userData;

  UserLoaded({required this.userData});
}

final class UserLoading extends UserState {}
