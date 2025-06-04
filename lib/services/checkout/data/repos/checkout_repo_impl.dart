
import 'package:dartz/dartz.dart';
import 'package:peto_care/core/errors/failure.dart';
import 'package:peto_care/core/utils/stripe_service.dart';
import 'package:peto_care/services/checkout/data/models/payment_intent_input_model.dart';
import 'package:peto_care/services/checkout/data/repos/checkout_repo.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);

      return right(null);
    } on StripeException catch (e) {
      return left(ServerFailure(
          e.error.message ?? 'Oops there was an error'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
