import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

 
class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);
 
  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}
 
class _StripePaymentScreenState extends State<StripePaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPaymentSheet();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe In Flutter"),
      ),
      body: Center(
        child: Card(
          child: ElevatedButton(
              onPressed: _displayPaymentSheet,
              child: const Text("Open Payment Sheet")),
        ),
      ),
    );
  }
 
  Future<void> initPaymentSheet() async {
    try {
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: const stripe.SetupPaymentSheetParameters(
          customFlow: true,
          merchantDisplayName: 'Flutter Stripe Demo',
          paymentIntentClientSecret: "",
          customerEphemeralKeySecret: "",
          customerId: "",
          setupIntentClientSecret: "",
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }
 
  Future<void> _displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet(
          options: const stripe.PaymentSheetPresentOptions(timeout: 1200000));
 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successfully completed'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }
}
 