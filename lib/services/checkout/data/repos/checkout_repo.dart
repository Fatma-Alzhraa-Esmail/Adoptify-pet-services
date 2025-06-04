import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/services/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
