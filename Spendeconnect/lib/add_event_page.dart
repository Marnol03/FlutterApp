import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class HilfePage extends StatefulWidget {
  const HilfePage({super.key});

  @override
  State<HilfePage> createState() => _HilfePageState();
}

class _HilfePageState extends State<HilfePage> {

  final _formKey = GlobalKey<FormState>();
  final NameController = TextEditingController();
  final VornameController = TextEditingController();
  String selectedMenu ='talk';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    NameController.dispose();
    VornameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          key : _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'NaMe ',
                        hintText : 'entrez votre nom',
                      border : OutlineInputBorder(),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return " tu dois remplir ce champ ";
                    }
                    return null ;
                  },
                  controller: NameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vorname ',
                    hintText : 'entrez votre nom',
                    border : OutlineInputBorder(),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return " tu dois remplir ce champ ";
                    }
                    return null ;
                  },
                  controller: VornameController,
                ),
              ),
              DropdownButtonFormField(
                 items :const [
                    DropdownMenuItem(value:'talk', child : Text("menu 1")),
                   DropdownMenuItem(value:'demo', child : Text("menu 2")),
                   DropdownMenuItem(value:'kass', child : Text("menu 3")),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  value: selectedMenu,
                  onChanged: (value){
                   setState(() {
                     selectedMenu = value!;
                   });
                  }
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Date',
                  ),
                  mode: DateTimeFieldPickerMode.dateAndTime,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      selectedDate =value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height:50,

                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      onPressed: (){
                        if( _formKey.currentState!.validate()){
                          final Name =NameController.text;
                          final Vorname =VornameController.text;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text ("envoi en cours ..."))
                          );
                          Focus.of(context).requestFocus(FocusNode()); // pour fermer le clavier lors de l envoi
                        // ajouts dans la bases de donnes ou pud precisement dans les events 
                         CollectionReference eventsRef = FirebaseFirestore.instance.collection("events");
                         eventsRef.add({
                           'nom' : Name,
                           'date de debut' : selectedDate,
                           'prenom' : Vorname,

                         });
                             }
                      },
                      child: Text("envoyer")
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

