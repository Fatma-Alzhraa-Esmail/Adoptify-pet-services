import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/address/manager/cubit/address_cubit.dart';
import 'package:peto_care/services/address/pages/add_address.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class AddressListView extends StatelessWidget {
  const AddressListView({
    super.key,
    required this.cubit,
    required this.shippingMethodController,
    required this.noteController,
  });

  final AddressCubit cubit;
  final TextEditingController shippingMethodController;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Address list takes available space
        AddressesListBody(cubit: cubit),
        // Shipping method and note section (no Expanded)
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.grey.shade400,
                height: 2,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  controller: shippingMethodController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(right: 20),
                    prefixText: "Standard Shipping ",
                    prefixStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                    label: const Text("SHIPPING METHOD"),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Colors.grey.shade500,
                    ),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: cubit.noteController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    onChanged: (value) {
                      cubit.noteController.text = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Write a note",
                      prefixStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.grey.shade500,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
        // Continue button
      
      ],
    );
  }
}

class AddressesListBody extends StatelessWidget {
  const AddressesListBody({
    super.key,
    required this.cubit,
  });

  final AddressCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 1),
        scrollDirection: Axis.vertical,
        itemCount: cubit.addressList.length,
        itemBuilder: (context, index) => Container(
          width: MediaHelper.width,
          child: Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.28,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    CustomNavigator.push(
                      Routes.editAddress,
                      arguments: cubit.addressList[index],
                    );
                  },
                  icon: Icons.edit,
                  foregroundColor: Colors.amber[600],
                  autoClose: true,
                ),
                SlidableAction(
                  onPressed: (context) {
                    // TODO: Implement delete address functionality
                  },
                  icon: Icons.delete,
                  foregroundColor: Colors.red,
                ),
              ],
            ),
            child: AddAddressWidget(
              context,
              cubit.addressList[index],
              cubit,
            ),
          ),
        ),
      ),
    );
  }
}
