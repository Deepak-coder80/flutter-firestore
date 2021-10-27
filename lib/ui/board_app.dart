import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  late TextEditingController nameInputController;
  late TextEditingController titleInputController;
  late TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firbase Firestore"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: const Icon(
          FontAwesomeIcons.pen,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('board').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                return Text(snapshot.data!.docs[index]['title']);
              });
        },
      ),
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: Column(
            children: [
              const Text("Please fill out the form"),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: const InputDecoration(
                    labelText: "Your name",
                  ),
                  controller: nameInputController,
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: const InputDecoration(
                    labelText: "title",
                  ),
                  controller: titleInputController,
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: const InputDecoration(
                    labelText: "description",
                  ),
                  controller: descriptionController,
                ),
              ),
            ],
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                nameInputController.clear();
                titleInputController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                if (titleInputController.text.isNotEmpty &&
                    nameInputController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection('board').add({
                    'name': nameInputController.text.toString(),
                    'title': titleInputController.text.toString(),
                    'description': descriptionController.text.toString(),
                    'timestamp': DateTime.now()
                  }).then((value) {
                    // ignore: avoid_print
                    print(value.id);
                    Navigator.pop(context);
                    nameInputController.clear();
                    titleInputController.clear();
                    descriptionController.clear();
                    // ignore: avoid_print
                  }).catchError((error) => print("error"));
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        );
      },
    );
  }
}
