import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:stripe/Features/checkout/data/models/amount_model.dart';
import 'package:stripe/Features/checkout/data/models/items_model.dart';
import 'package:stripe/Features/checkout/presentation/views/widgets/custom_btn_bloc_cons.dart';
import 'package:stripe/Features/checkout/presentation/views/widgets/payment_method_item.dart';
import 'package:stripe/core/api_keys/api_key.dart';
import 'package:stripe/core/widgets/custom_button.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  final List<String> paymentMethodsItems = const [
    'assets/images/card.svg',
    'assets/images/paypal.svg'
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 62,
            child: ListView.builder(
                itemCount: paymentMethodsItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        activeIndex = index;
                        setState(() {});
                      },
                      child: PaymentMethodItem(
                        isActive: activeIndex == index,
                        image: paymentMethodsItems[index],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 32,
          ),
          if (activeIndex == 0) CustomBtnBlocCons(),
          if (activeIndex == 1)
            CustomButton(
              text: "Continue",
              onTap: () {
                var transactionData = getTransactionData();
                exceutePayPalPayment(context, transactionData);
              },
            ),
        ],
      ),
    );
  }

  void exceutePayPalPayment(BuildContext context,
      ({AmountModel amount, ItemsModel itemList}) transactionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKey.paypalClientId,
        secretKey: ApiKey.paypalSercetKey,
        transactions: [
          {
            "amount": transactionData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({AmountModel amount, ItemsModel itemList}) getTransactionData() {
    var amount = AmountModel(
        total: "88",
        currency: "USD",
        details:
            AmountDetails(subtotal: "88", shipping: "0", shippingDiscount: 0));

    List<OrderItemsModel> orders = [
      OrderItemsModel(
        name: "Apple",
        price: "4",
        quantity: 10,
        currency: "USD",
      ),
      OrderItemsModel(
        name: "Apple",
        price: "4",
        quantity: 12,
        currency: "USD",
      ),
    ];

    var itemList = ItemsModel(
      items: orders,
    );

    return (
      amount: amount,
      itemList: itemList,
    );
  }
}
