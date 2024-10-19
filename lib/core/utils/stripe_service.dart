import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:stripe/core/utils/api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
        body: paymentIntentInputModel.toJson(),
        url: "https://api.stripe.com/v1/payment_intents",
        token:
            "sk_test_51Q1Izg2LjTgCslLUYidEgZXPoiLCEHKQ6iSNg2O5p8LDXhCNHuHcH2ijZUvpds7yyDxF2xXTUCsrdgSObNBu0wvU00x9SEtQWY");

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({
    required String paymentIntentClientSecret,
  }) async {
    Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: "Icarus",
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
