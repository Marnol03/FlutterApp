import 'package:flutter/material.dart';

class CreditCardPayment extends StatefulWidget {
  const CreditCardPayment({super.key});

  @override
  State<CreditCardPayment> createState() => _CreditCardPaymentState();
}

class _CreditCardPaymentState extends State<CreditCardPayment> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Visa Card"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10,left:20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'CardNumber',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10,left:20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
