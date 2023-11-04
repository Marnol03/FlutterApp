import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/create_pub_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double currentAmount = 4000.50;

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
                double totalAmount = post["amount"].toDouble();
                return Column(
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/profil.png"),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 15),
                          Text("pseudo",
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Couleur de la barre de progression
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
                              onPressed:(){},
                              icon: const Icon(Icons.favorite_outline)
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
                            onPressed: () {},
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