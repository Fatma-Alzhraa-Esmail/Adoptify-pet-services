import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/services/address/manager/cubit/address_cubit.dart';
import 'package:peto_care/services/address/repo/address_repo/address_repo_impl.dart';
import 'package:peto_care/services/shippingFlow/widgets/address_empty_list_view.dart';
import 'package:peto_care/services/shippingFlow/widgets/address_list_view.dart';

// ignore: must_be_immutable
class DeliverToWidget extends StatelessWidget {
  DeliverToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AddressCubit(AddressRepoImpl())..fetchAddress(),
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (BuildContext context, AddressState state) {
          if (state is FetchAllAddressSuccess) {
            AddressCubit cubit = context.read<AddressCubit>();
          } else if (State is ChangedSelectedState) {
          } else if (State is IntialEditAddressState) {}
        },
        builder: (context, state) {
          AddressCubit cubit = context.read<AddressCubit>();
          return cubit.addressList.isNotEmpty
              ? AddressListView(
                  cubit: cubit,
                  shippingMethodController: cubit.shippingMethodController,
                  noteController: cubit.noteController)
              : AddressEmptyListView();
        },
      ),
    );
  }
}
