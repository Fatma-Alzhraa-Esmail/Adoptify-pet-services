import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/handlers/location_select/location_select.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/services/address/manager/cubit/address_cubit.dart';
import 'package:peto_care/services/address/model/address.dart';
import 'package:peto_care/services/address/repo/address_repo/address_repo_impl.dart';
import 'package:peto_care/services/address/widgets/address_phone_text_field.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/components/fields/text_input_field.dart';
import 'package:peto_care/utilities/components/success_popup.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

import '../../../handlers/location_select/model/address_details_model.dart';

// ignore: must_be_immutable
class EditAddress extends StatelessWidget {
  EditAddress({required this.address});
  final AddressModel address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'New Address',
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
          child: BlocProvider(
        create: (context) => AddressCubit(AddressRepoImpl())
          ..intialEditingAddress(address: address),
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            AddressCubit addressCubit = context.read<AddressCubit>();
            if (state is FormEmptyState) {
              addressCubit.formValidate = state.formEmpty;
              print(addressCubit.formValidate);
            } else if (state is EditAddressSuccess) {
              showCustomDialog(
                context,
                content: "Yout address updated successfully",
              );
              CustomNavigator.pop();
            }
          },
          builder: (context, state) {
            AddressCubit Address = context.read<AddressCubit>();

            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          label: 'Full Name',
                          hintText: 'Enter your full name',
                          controller: Address.nameController,
                          errorText: 'please enter ur full name',
                          keyboardType: TextInputType.text,
                          hasError: !Address.nameIsValid,
                          onChange: (p0) {
                            Address.isEmpty();
                            if (!Address.nameIsValid) {
                              Address.nameIsValid = true;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          label: 'ADDRESS',
                          hintText: 'Enter your address',
                          controller: Address.addressController,
                          errorText: 'please enter ur address',
                          keyboardType: TextInputType.streetAddress,
                          hasError: !Address.addressIsValid,
                          onChange: (p0) async {
                            AddressDetailsModel? addressDetailsModel =
                                await LocationSelect.customAddressPicker(
                                    context);
                            print("addressDetailsModel $addressDetailsModel");
                            if (addressDetailsModel != null) {
                              Address.assignAddress(
                                  address: addressDetailsModel);
                            }
                            Address.isEmpty();
                            if (!Address.addressIsValid) {
                              Address.addressIsValid = true;
                            }
                          },
                          suffixIcon: Icon(
                            Icons.room_outlined,
                            size: 26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),

                        child: PhoneFieldWidget(
                            bloc: Address, number: Address.number),
                        // child: TextInputField(
                        //   label: 'PHONE NUMBER',
                        //   hintText: 'Enter your phone',
                        //   controller: PhoneNumbercontroller,
                        //   errorText: 'please enter ur phone',
                        //   keyboardType: TextInputType.phone,
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          label: 'CITY',
                          hintText: 'Enter your city',
                          controller: Address.cityController,
                          errorText: 'please enter ur city',
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          keyboardType: TextInputType.text,
                          hasError: !Address.cityIsValid,
                          onChange: (p0) {
                            Address.isEmpty();
                            if (!Address.cityIsValid) {
                              Address.cityIsValid = true;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextInputField(
                          label: 'COUNTRY',
                          hintText: 'Enter your country',
                          controller: Address.countryController,
                          errorText: 'please enter ur country',
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          keyboardType: TextInputType.text,
                          hasError: !Address.countryIsValid,
                          onChange: (p0) {
                            Address.isEmpty();
                            if (!Address.countryIsValid) {
                              Address.countryIsValid = true;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: CustomBtn(
                //     height: 50,
                //     text: Text('SAVE'),
                //     buttonColor: Colors.amber[600],
                //     onTap: () {},
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                  child: BlocConsumer<AddressCubit, AddressState>(
                    listener: (context, state) {
                      if (state is FormEmptyState) {
                        Address.formValidate = state.formEmpty;
                        print(Address.formValidate);
                      } else if (state is FormValidateState) {
                        print(state.formValidate);
                      } else if (state is AddAddressSuccess) {
                        showCustomDialog(context,
                            headerTitle: 'Success',
                            content: 'Your Address is added successfully.');
                        showCustomDialog(context);
                      } else if (state is AddAddressFailure) {}
                    },
                    builder: (context, state) {
                      return CustomBtn(
                        isFeedback: !Address.formValidate ? false : true,
                        text: Address.isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 6,
                                strokeCap: StrokeCap.round,
                              )
                            : Text('SAVE',
                                style: AppTextStyles.w600
                                    .copyWith(color: Colors.white)),
                        buttonColor: !Address.formValidate
                            ? Colors.amber.withOpacity(0.4)
                            : Colors.amber,
                        borderColor: !Address.formValidate
                            ? Colors.amber.withOpacity(0.4)
                            : Colors.amber,
                        height: 44,
                        onTap: () {
                          if (!Address.formValidate) {
                          } else {
                            Address.editAddress(addressId: address.id!);
                            CustomNavigator.pop();
                            
                          }
                        },
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: 16,
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
