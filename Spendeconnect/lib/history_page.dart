import 'package:flutter/material.dart';
import 'package:myapp/create_pub_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final publication = [
    {
      "title": "Cancer du foie",
      "date": "12.07.2022",
      "text": "j´ai un cancer du foie depuis mes 3 ans",
      "photo": "daniella",
    },
    {
      "title": "Accident de voiture ",
      "date": "12.07.2022",
      "text": "j´ai fais un accident il y a 1 ans",
      "photo": "blackscreen",
    },
    {
      "title": "Cancer du foie",
      "date": "12.07.2022",
      "text": "j´ai un cancer du foie depuis mes 3 ans",
      "photo": "daniella",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: publication.length,
          itemBuilder: (context, index){
            final pub = publication [index];
            final image = pub ['photo'];
            final title = pub ['title'];
            final text = pub ['text'];
            return Card(
              child: ListTile(
                leading: Image.asset("assets/images/$image.jpeg"),
                title:  Text('$title',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                subtitle: Text("$text"),
                trailing: Icon(Icons.more_vert),
              ),
            );
          }
      ),
    );
  }
}
