import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:peto_care/services/cart/widget/confirmed.dart';
import 'package:peto_care/services/shippingFlow/manager/shipping_stepper_cubit/shipping_stepper_state.dart';
import 'package:peto_care/services/shippingFlow/models/model.dart';
import 'package:peto_care/services/shippingFlow/pages/payment_medthod.dart';
import 'package:peto_care/services/shippingFlow/widgets/deliverto.dart';

class ShippingStepperCubit extends Cubit<ShippingStepperState> {
  ShippingStepperCubit() : super(ShippingStepperIntialState());

  String selectedPaymentMethod = SelectedPaymentMethod.card.name;
  static ShippingStepperCubit get(context) => BlocProvider.of(context);
  int currentScreen = 0;
  List<String> appbarTitle = ["Delivered To", "Payment Methode","Order Review", "Confirm"];
  List<String> buttonTitle = ["CONTINUE", "CONTINUE","PAY","CONTINUE SHOPPING"];
  // List<Widget> stepper = [DeliverToWidget(), CartPayment( ), ConfirmedWidget()];

  void changeStepperLevel({required int index}) {
    currentScreen = index;
    emit(ChangeStepperIndexState());
  }
  void SelectedPayment({required String method}) {
  selectedPaymentMethod = method;
    emit(ChangeMethodState());
  }

}
