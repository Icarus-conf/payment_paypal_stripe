class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  toJson() {
    return {
      'amount': (double.parse(amount) * 100).toInt(),
      'currency': currency,
      'customer': customerId,
    };
  }
}
