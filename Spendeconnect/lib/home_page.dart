import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/credit_card_payment.dart';
import 'package:myapp/paypal_payment.dart';

import 'authentificate_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {



    return SingleChildScrollView(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Post").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return const Text("the is no publication");
            }

            List<dynamic> postItems = [];
            snapshot.data!.docs.forEach((element) {
              postItems.add(element);
            });
            return Column(
              children: postItems.map((post) {
                double currentAmount =  double.parse(post["gift"].toString());
                double totalAmount = double.parse(post["amount"].toString());
                String postID = post.id;
                return Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child:  const Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/profil.png"),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text('pseudo',
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(post['image_url']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(post["title"],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                     child:
                      Text(post["text"]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text("$currentAmount"),
                          SizedBox(
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearProgressIndicator(
                                minHeight: 20,
                                value: currentAmount / totalAmount,
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                          ),
                          Text("$totalAmount"),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                              },
                              icon:  Icon(
                                isFavorited ? Icons.favorite : Icons.favorite_outline,
                                color: isFavorited ? Colors.red : null,
                              )
                          ),
                          IconButton(
                              onPressed:(){},
                              icon: const Icon(Icons.bookmark_outline)
                          ),
                          Expanded(child: Container()),
                          ElevatedButton.icon(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.green),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Choose you payment method:"),
                                    content: Row(
                                      children: [
                                        const SizedBox(width:20),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>  PaypalPayment(postID: postID),
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/paypal.png',
                                              width: 200.0,
                                              height: 200.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:(context) => CreditCardPayment(postID: postID)
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/credit-card.png',
                                              width: 200.0,
                                              height: 200.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          ),
                                      ],
                                    )
                                  )
                              );

                            },
                            label: const Text("Spenden",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"
                              ),
                            ),
                            icon: const Icon(Icons.monetization_on_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}
