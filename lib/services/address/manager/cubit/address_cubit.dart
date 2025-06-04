import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:meta/meta.dart';
import 'package:peto_care/core/validator/validator.dart';
import 'package:peto_care/handlers/location_select/model/address_details_model.dart';
import 'package:peto_care/services/address/model/address.dart';
import 'package:peto_care/services/address/repo/address_repo/address_repo.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> with Validations {
  final AddressRepo _addressRepo;
  AddressCubit(this._addressRepo) : super(AddressInitial());

  //=====================================================
  // Variables
  //=====================================================
  bool formValidate = false;
  bool isLoading = false;
  List<AddressModel> addressList = [];
  bool isAllAddressLoading = false;

  // For Name
  TextEditingController nameController = TextEditingController();
  String nameError = '';
  bool nameIsValid = true;

  // For Address
  TextEditingController addressController = TextEditingController();
  String addressError = '';
  bool addressIsValid = true;

  // For Phone
  TextEditingController phoneController = TextEditingController();
  String phoneError = '';
  bool phoneIsValid = true;

  // For City
  TextEditingController cityController = TextEditingController();
  String cityError = '';
  bool cityIsValid = true;

  // For Country
  TextEditingController countryController = TextEditingController();
  String countryError = '';
  bool countryIsValid = true;

  TextEditingController shippingMethodController = TextEditingController(
    text: "(+\$5.5)",
  );

  TextEditingController noteController = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');
  String phoneNumber = '';
  double latitude = 0.0;
  double longitude = 0.0;
  AddressDetailsModel? addressDetails;
  AddressModel? selectedAddress;

  //=====================================================
  // Functions
  //=====================================================

  void assignAddress({required AddressDetailsModel address}) {
    print("addressDetails $address");
    addressDetails = address;
    if (address != null) {
      addressController.text = address.fullAddress ?? '';
      cityController.text = address.cityName ?? '';
      countryController.text = address.country ?? '';
      emit(AssignAddressDetails());
    }
  }
  DateTime? address_updated_at ;
  void intialEditingAddress({required AddressModel address}) {
    addressController.text = address.location ?? '';
    cityController.text = address.city ?? '';
    countryController.text = address.country ?? '';
    nameController.text = address.name ?? '';
    phoneController.text = (address.phoneNumber ?? '');
    address_updated_at = address.updated_at;
      addressDetails=AddressDetailsModel(
        cityName:address.city ?? '' ,
        country: address.country ?? '',
        fullAddress: address.location ?? '',
        latLng: LatLng(
          latlang: address.longitude ?? 0.0,
          lattitude: address.latitude ?? 0.0,
        ),
             


      );
    number = PhoneNumber(
      phoneNumber: address.phoneNumber ?? '',
      dialCode: address.dialCode,
      isoCode: address.countryCode,
    );
    initialCountry = address.countryCode ?? 'EG';
    phoneNumber = address.phoneNumber ?? '';


    emit(IntialEditAddressState());
  }

  void changeSelectedAddress(AddressModel newSelectedAddress) {
    selectedAddress = newSelectedAddress;
    emit(ChangedSelectedState());
  }

  bool isEmpty() {
    var formIsEmpty = nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        initialCountry.isNotEmpty &&
        countryController.text.isNotEmpty &&
        cityController.text.isNotEmpty;
        
    print("Form is empty: $formIsEmpty");
    emit(FormEmptyState(formEmpty: formIsEmpty));
    return formIsEmpty;
  }
  
  void fetchAddress() {
    isAllAddressLoading = true;
    emit(FetchAllAddressLoading());

    _addressRepo.getAllUserAdressess().listen(
      (either) {
        either.fold(
          (failure) {
            emit(FetchAllAddressFailure(errMessage: failure.errMessage));
            isAllAddressLoading = false;
          },
          (allAddresses) {
            addressList = allAddresses;
            if (allAddresses.isNotEmpty) {
              selectedAddress = allAddresses[0];
            }
            emit(FetchAllAddressSuccess());
            isAllAddressLoading = false;
          },
        );
      },
      onError: (error) {
        emit(FetchAllAddressFailure(errMessage: error.toString()));
        isAllAddressLoading = false;
      },
    );
  }

  bool validate() {
    nameError = isValidName(nameController.text);
    addressError = addressController.text.isEmpty ? 'Address is required' : '';
    cityError = cityController.text.isEmpty ? 'City is required' : '';
    countryError = countryController.text.isEmpty ? 'Country is required' : '';
    phoneError = phoneController.text.isEmpty ? 'Phone number is required' : '';

    nameIsValid = nameError.isEmpty;
    addressIsValid = addressError.isEmpty;
    cityIsValid = cityError.isEmpty;
    countryIsValid = countryError.isEmpty;
    phoneIsValid = phoneError.isEmpty;

    bool formValidate = nameIsValid &&
        addressIsValid &&
        cityIsValid &&
        countryIsValid &&
        phoneIsValid;
    print("Validation result: $formValidate");
    return formValidate;
  }

  Future<AddressModel?> addNewAddress() async {
    print('Validation result: ${validate()}');
    if (validate()) {
      isLoading = true;
      emit(AddAddressLoading());

      var addNewAddress = await _addressRepo.addNewAddress(AddressModel(
        city: cityController.text,
        country: countryController.text,
        location: addressController.text,
        name: nameController.text,
        phoneNumber: phoneNumber,
        countryCode: initialCountry,
        dialCode: number.dialCode,
        latitude: addressDetails?.latLng?.lattitude ?? 0.0,
        longitude: addressDetails?.latLng?.latlang ?? 0.0,
        updated_at: DateTime.now(),
      ));

      return addNewAddress.fold(
        (failure) {
          emit(AddAddressFailure(
              errMessage: 'There was an error, please try again'));
          isLoading = false;
          return null;
        },
        (address) {
          addressList.add(address);
          selectedAddress = address;
          emit(AddAddressSuccess());
          isLoading = false;
          return address;
        },
      );
    } else {
      isLoading = false;
      emit(FormValidateState(formValidate: 'Validation Error'));
      return null;
    }
  }

  Future<AddressModel?> editAddress({required String addressId}) async {
    print('Validation result: ${validate()}');
    if (validate()) {
      isLoading = true;
      emit(EditAddressLoading());

      var editAddressResult = await _addressRepo.editAddress(AddressModel(
        id: addressId,
        city: cityController.text,
        country: countryController.text,
        location: addressController.text,
        name: nameController.text,
        phoneNumber: phoneNumber,
        countryCode: number.isoCode,
        dialCode: number.dialCode,
        latitude: addressDetails?.latLng?.lattitude ?? 0.0,
        longitude: addressDetails?.latLng?.latlang ?? 0.0,
        updated_at: address_updated_at,

      ));

      return editAddressResult.fold(
        (failure) {
          emit(EditAddressFailure(
              errMessage: 'There was an error, please try again'));
          isLoading = false;
          return null;
        },
        (address) {
          // Update the address in the addressList
          final index = addressList.indexWhere((a) => a.id == address.id);
          if (index != -1) {
            addressList[index] = address;
          }
          selectedAddress = address;
            isLoading = false;
                      emit(EditAddressSuccess());

          return address;
        
        },
      );
    } else {
      isLoading = false;
      emit(FormValidateState(formValidate: 'Validation Error'));
      return null;
    }
  }
}