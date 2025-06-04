import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto_care/handlers/icon_handler.dart';
import 'package:peto_care/services/shippingFlow/manager/shipping_stepper_cubit/shipping_stepper_cubit.dart';
import 'package:peto_care/services/shippingFlow/models/model.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/colors/light_theme.dart';
import 'package:peto_care/utilities/theme/media.dart';

class CartPayment extends StatelessWidget {
  const CartPayment({super.key, required this.shippingcubit});
  final ShippingStepperCubit shippingcubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LightTheme().background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: SizedBox(
              width: MediaHelper.width,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        BlocProvider.of<ShippingStepperCubit>(context)
                            .SelectedPayment(
                                method: SelectedPaymentMethod.card.name);
                        // showMyDialog(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color:
                                  BlocProvider.of<ShippingStepperCubit>(context)
                                              .selectedPaymentMethod ==
                                          SelectedPaymentMethod.card.name
                                      ? Colors.amber
                                      : Colors.black.withOpacity(0.088),
                              width: BlocProvider.of<ShippingStepperCubit>(context)
                                              .selectedPaymentMethod ==
                                          SelectedPaymentMethod.card.name?2: 0.5),
                          boxShadow:
                              BlocProvider.of<ShippingStepperCubit>(context)
                                          .selectedPaymentMethod ==
                                      SelectedPaymentMethod.card.name
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.088),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: drawSvgIconColored('card1',
                                  height: 45, width: 45),
                            ),
                            const Text(
                              "Card",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        BlocProvider.of<ShippingStepperCubit>(context)
                            .SelectedPayment(
                                method: SelectedPaymentMethod.cash.name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  BlocProvider.of<ShippingStepperCubit>(context)
                                              .selectedPaymentMethod ==
                                          SelectedPaymentMethod.cash.name
                                      ? Colors.amber
                                      :  Colors.black.withOpacity(0.088),
                              width:  BlocProvider.of<ShippingStepperCubit>(context)
                                              .selectedPaymentMethod ==
                                          SelectedPaymentMethod.cash.name?2:0.5),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow:
                              BlocProvider.of<ShippingStepperCubit>(context)
                                          .selectedPaymentMethod ==
                                      SelectedPaymentMethod.cash.name
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.088),
                                        spreadRadius: 0,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: drawSvgIconColored('Money',
                                  height: 48, width: 48),
                            ),
                            const Text(
                              "Cash",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Choose Card To Payment')),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 21,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          content: SizedBox(
            height: 250,
            child: Center(
              child: Image.asset(
                "assets/images/choose_card.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomBtn(
                buttonColor: Colors.amber,
                text: const Text('OK'),
                height: 56,
                onTap: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
