import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:stripe/core/api_keys/api_key.dart';

void main() {
  Stripe.publishableKey = ApiKey.stripePubKey;
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
