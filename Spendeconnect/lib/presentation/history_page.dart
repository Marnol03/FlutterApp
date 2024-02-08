import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final publication = [
    {
      "title": "Help Fight Liver Cancer",
      "date": "12.07.2022",
      "text": "I am writing to you today with a heavy heart",
      "photo": "photo2",
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
                leading: Image.asset("assets/images/$image.jpg"),
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
