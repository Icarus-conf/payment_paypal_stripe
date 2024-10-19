import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/Features/checkout/data/models/ephm_key_model.dart';
import 'package:stripe/Features/checkout/data/models/init_paymentsheet_input_model.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:stripe/core/api_keys/api_key.dart';
import 'package:stripe/core/utils/api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: "https://api.stripe.com/v1/payment_intents",
      token: ApiKey.stripeSecretKey,
      contentType: Headers.formUrlEncodedContentType,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({
    required InitPaymentsheetInputModel initPaymentsheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: initPaymentsheetInputModel.clientSecert,
      merchantDisplayName: "Icarus",
      customerEphemeralKeySecret: initPaymentsheetInputModel.ephmKey,
      customerId: initPaymentsheetInputModel.customerId,
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);

    var ephmKeyModel = await createEmphKey(
      customerId: paymentIntentInputModel.customerId,
    );

    var initPaymentSheetInputModel = InitPaymentsheetInputModel(
        clientSecert: paymentIntentModel.clientSecret!,
        customerId: paymentIntentInputModel.customerId,
        ephmKey: ephmKeyModel.secret);

    await initPaymentSheet(
        initPaymentsheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEmphKey({
    required String customerId,
  }) async {
    var response = await apiService.post(
      body: {
        'customer': customerId,
      },
      token: ApiKey.stripeSecretKey,
      headers: {
        'Authorization': "Bearer ${ApiKey.stripeSecretKey}",
        'Stripe-Version': "2024-06-20",
      },
      url: "https://api.stripe.com/v1/ephemeral_keys",
      contentType: Headers.formUrlEncodedContentType,
    );

    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);

    return ephemeralKeyModel;
  }
}
