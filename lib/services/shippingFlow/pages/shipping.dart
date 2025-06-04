import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/services/address/manager/cubit/address_cubit.dart';
import 'package:peto_care/services/address/repo/address_repo/address_repo_impl.dart';
import 'package:peto_care/services/cart/widget/confirmed.dart';
import 'package:peto_care/services/checkout/data/repos/checkout_repo_impl.dart';
import 'package:peto_care/services/checkout/presentation/manger/cubit/payment_cubit.dart';
import 'package:peto_care/services/checkout/presentation/views/widgets/payment_methods_bottom_sheet.dart';
import 'package:peto_care/services/shippingFlow/manager/shipping_stepper_cubit/shipping_stepper_cubit.dart';
import 'package:peto_care/services/shippingFlow/manager/shipping_stepper_cubit/shipping_stepper_state.dart';
import 'package:peto_care/services/shippingFlow/pages/payment_medthod.dart';
import 'package:peto_care/services/shippingFlow/pages/review_order.dart';
import 'package:peto_care/services/shippingFlow/widgets/deliverto.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';

import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

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
      }, builder: (context, state) {
        AddressCubit cubit = context.read<AddressCubit>();

        return BlocProvider(
          create: (context) =>
              ShippingStepperCubit()..changeStepperLevel(index: 0),
          child: BlocConsumer<ShippingStepperCubit, ShippingStepperState>(
              builder: (context, state) {
            ShippingStepperCubit shippingStepperCubit =
                context.read<ShippingStepperCubit>();
            return Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                title: Text(shippingStepperCubit
                    .appbarTitle[shippingStepperCubit.currentScreen]),
                leading: GestureDetector(
                    onTap: () {
                      CustomNavigator.pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
              ),
              body: SafeArea(
                  child: Container(
                height: MediaHelper.height,
                width: MediaHelper.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///////////////////////////////////1
                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: drawSvgIcon("location",
                                width: 30, height: 30, iconColor: Colors.amber),
                            onTap: () {
                              shippingStepperCubit.changeStepperLevel(index: 0);
                            },
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            height: 2,
                            color: (shippingStepperCubit.currentScreen == 1 ||
                                    shippingStepperCubit.currentScreen == 2 ||
                                    shippingStepperCubit.currentScreen == 3)
                                ? Colors.amber
                                : Colors.grey.shade500,
                          )),

                          ///////////////////////////////////////2

                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (cubit.selectedAddress != null) {
                                shippingStepperCubit.changeStepperLevel(
                                    index: 1);
                              }
                            },
                            child: drawSvgIcon(
                              "payment",
                              width: 30,
                              height: 30,
                              iconColor: (shippingStepperCubit.currentScreen ==
                                          1 ||
                                      shippingStepperCubit.currentScreen == 2 ||
                                      shippingStepperCubit.currentScreen == 3)
                                  ? Colors.amber
                                  : Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  height: 2,
                                  color: (shippingStepperCubit.currentScreen ==
                                              2 ||
                                          shippingStepperCubit.currentScreen ==
                                              3)
                                      ? Colors.amber
                                      : Colors.grey.shade500,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12))),

                          /////////////////////////////////3

                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (cubit.selectedAddress != null) {
                                shippingStepperCubit.changeStepperLevel(
                                    index: 2);
                              }
                            },
                            child: drawSvgIcon(
                              "order",
                              width: 26,
                              height: 26,
                              iconColor: (shippingStepperCubit.currentScreen ==
                                          2 ||
                                      shippingStepperCubit.currentScreen == 3)
                                  ? Colors.amber
                                  : Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  height: 2,
                                  color:
                                      (shippingStepperCubit.currentScreen == 3)
                                          ? Colors.amber
                                          : Colors.grey.shade500,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12))),

                          ///////////////////////////////////
                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (cubit.selectedAddress != null) {
                                shippingStepperCubit.changeStepperLevel(
                                    index: 3);
                              }
                            },
                            child: drawSvgIcon(
                              "confirm",
                              width: 30,
                              height: 30,
                              iconColor: shippingStepperCubit.currentScreen == 3
                                  ? Colors.amber
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: MediaHelper.width,
                          child: shippingStepperCubit.currentScreen == 0
                              ? DeliverToWidget()
                              : shippingStepperCubit.currentScreen == 1
                                  ? CartPayment(
                                      shippingcubit:
                                          ShippingStepperCubit.get(context))
                                  : shippingStepperCubit.currentScreen == 2
                                      ? ReviewOrder(
                                          selectedAddress:
                                              cubit.selectedAddress!,
                                          selectedPaymentMethod:
                                              shippingStepperCubit
                                                  .selectedPaymentMethod,
                                          shippingStepperCubit:
                                              shippingStepperCubit,
                                        )
                                      : ConfirmedWidget()),
                    ),
                    cubit.addressList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            child: CustomBtn(
                              onTap: () {
                                if (cubit.selectedAddress != null) {
                                  if (shippingStepperCubit.currentScreen < 2) {
                                    shippingStepperCubit.changeStepperLevel(
                                        index:
                                            shippingStepperCubit.currentScreen +
                                                1);
                                  } else if (shippingStepperCubit
                                          .currentScreen ==
                                      2) {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) => PaymentCubit(
                                                CheckoutRepoImpl()),
                                            child:
                                                const PaymentMethodsBottomSheet(),
                                          );
                                        });
                                  } else if (shippingStepperCubit
                                          .currentScreen ==
                                      3) {
                                    CustomNavigator.push(Routes.Navigation);
                                  }
                                }
                              },
                              text: Text(
                                "CONTINUE",
                                style: AppTextStyles.w600.copyWith(
                                    color: LightTheme().background,
                                    fontSize: 18),
                              ),
                              buttonColor: Colors.amber,
                              height: 56,
                            ),
                          )
                        : Container(),
                  ],
                ),
              )),
            );
          }, listener: (context, state) {
            if (state is ChangeStepperIndexState) {
            } else if (state is ChangeMethodState) {}
          }),
        );
      }),
    );
  }
}
