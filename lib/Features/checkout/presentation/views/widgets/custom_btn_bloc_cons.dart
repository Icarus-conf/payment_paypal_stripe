import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:stripe/Features/checkout/presentation/cubit/payment_cubit.dart';
import 'package:stripe/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:stripe/core/widgets/custom_button.dart';

class CustomBtnBlocCons extends StatelessWidget {
  const CustomBtnBlocCons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }
        if (state is PaymentFailure) {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(content: Text(state.errMsg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(
              amount: "100",
              currency: "USD",
              customerId: "cus_R3koHkt95GRFAa",
            );
            BlocProvider.of<PaymentCubit>(context)
                .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          text: 'Continue',
          isLoading: state is PaymentLoading ? true : false,
        );
      },
    );
  }
}
