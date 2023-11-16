import 'package:flutter/material.dart';


class PaypalPayment extends StatefulWidget {
  const PaypalPayment({super.key});

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("PAYPAL"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10,left:20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10,left:20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
