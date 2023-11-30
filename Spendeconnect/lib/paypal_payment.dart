import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';


class PaypalPayment extends StatefulWidget {
  final String postID;
  PaypalPayment({Key? key, required this.postID}) : super(key: key);

  @override
  State<PaypalPayment> createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {

  final amountGift = TextEditingController();

  @override

  void dispose() {
    super.dispose();

    amountGift.dispose();
  }
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "you must feel this feld";
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "you must feel this feld";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10,left:20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'amount to gift',
                //border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "you must feel this feld";
                }
                return null;
              },
              controller: amountGift,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green),
             ),
            onPressed: () {

            double donationAmount = double.tryParse(amountGift.text) ?? 0.0;
            updateAmount(widget.postID, donationAmount);
            showConfirmationAndRedirect(context);
            setState(() {
              amountGift.clear();
            });
          },
        label: const Text("Spenden"),
        icon: const Icon(Icons.monetization_on),
          )
        ],
      ),
    );
  }
}
Future<void> updateAmount(String postID, double donationAmount) async {
  try {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection('Post');

    QuerySnapshot postQuery = await postsCollection.where(FieldPath.documentId, isEqualTo: postID).get();

    if (postQuery.docs.isNotEmpty) {
      DocumentSnapshot postSnapshot = postQuery.docs.first;
      double currentAmount = (postSnapshot.data() as Map<String, dynamic>).containsKey('gift')
          ? (postSnapshot.data() as Map<String, dynamic>)['gift'].toDouble()
          : 0.0;

      double newAmount = currentAmount + donationAmount;

      await postsCollection.doc(postID).update({'gift': newAmount});
    } else {
      print('the publication with the ID $postID does not exist.');
    }
  } catch (error) {
    print('Error when updating the AmountGift : $error');
  }
}
Future<void> showConfirmationAndRedirect(BuildContext context) async {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Your payment have been successful done !'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
