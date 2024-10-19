import 'package:dartz/dartz.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:stripe/Features/checkout/data/repos/checkout_repo.dart';
import 'package:stripe/core/error/failure.dart';
import 'package:stripe/core/error/server_failure.dart';
import 'package:stripe/core/utils/stripe_service.dart';

class CheckoutImplRepo extends CheckoutRepo {
  final StripeService service = StripeService();

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await service.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMsg: e.toString()));
    }
  }
}
