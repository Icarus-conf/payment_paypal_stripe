import 'package:flutter/material.dart';
import 'package:stripe/Features/checkout/presentation/views/widgets/custom_btn_bloc_cons.dart';
import 'package:stripe/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          CustomBtnBlocCons(),
        ],
      ),
    );
  }
}
