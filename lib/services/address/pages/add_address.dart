import 'package:flutter/material.dart';
import 'package:peto_care/services/address/manager/cubit/address_cubit.dart';
import 'package:peto_care/services/address/model/address.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

// ignore: must_be_immutable
class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget(this.context, this.address, this.cubit, {super.key});

  final BuildContext context;
  final AddressModel address;
  final AddressCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        cubit.changeSelectedAddress(address);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: cubit.selectedAddress == address
                  ? LightTheme().mainColor
                  : Colors.black38,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: SizedBox(
              height: 130, // Fixed height for consistency in list items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    address.location ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    address.phoneNumber ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
