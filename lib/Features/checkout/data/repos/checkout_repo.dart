import 'package:dartz/dartz.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:stripe/core/error/failure.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
