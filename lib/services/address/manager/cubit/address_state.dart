part of 'address_cubit.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class FetchAllAddressSuccess extends AddressState {}

final class FetchAllAddressLoading extends AddressState {}

final class FetchAllAddressFailure extends AddressState {
  final String errMessage;

  FetchAllAddressFailure({required this.errMessage});
}

class FormEmptyState extends AddressState {
  bool formEmpty;
  FormEmptyState({required this.formEmpty});
}

class AddAddressLoading extends AddressState {}

class AddAddressSuccess extends AddressState {}

final class AddAddressFailure extends AddressState {
  final String errMessage;

  AddAddressFailure({required this.errMessage});
}


// ignore: must_be_immutable
class FormValidateState extends AddressState {
  String formValidate;
  FormValidateState({required this.formValidate});
}

class AssignAddressDetails extends AddressState {}
class ChangedSelectedState extends AddressState {}
class IntialEditAddressState extends AddressState {}
class EditAddressSuccess extends AddressState {}
class EditAddressLoading extends AddressState {}
final class EditAddressFailure extends AddressState {
  final String errMessage;

  EditAddressFailure({required this.errMessage});
}