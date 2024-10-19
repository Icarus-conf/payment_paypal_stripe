class AmountModel {
  String total;
  String currency;
  AmountDetails details;

  AmountModel({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'],
      currency: json['currency'],
      details: AmountDetails.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'currency': currency,
      'details': details.toJson(),
    };
  }
}

class AmountDetails {
  String subtotal;
  String shipping;
  int shippingDiscount;

  AmountDetails({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      shippingDiscount: json['shipping_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount,
    };
  }
}
