// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CardView extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  const CardView({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snpdata = snapshot.docs[index];
    TextEditingController nameInputController =
        TextEditingController(text: snpdata['name']);
    TextEditingController titleInputController =
        TextEditingController(text: snpdata['title']);
    TextEditingController descriptionController =
        TextEditingController(text: snpdata['description']);
    var docId = snapshot.docs[index].id;
    var timeToDate = DateTime.fromMillisecondsSinceEpoch(
        snapshot.docs[index]['timestamp'].seconds * 1000);
    var dateFormatted = DateFormat("EEEE,MM,y").format(timeToDate);
    return Column(
      children: [
        Container(
          height: 200,
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Column(
              children: [
                ListTile(
                  title: Text(snapshot.docs[index]['title']),
                  subtitle: Text(snapshot.docs[index]['description']),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(snapshot.docs[index]['title']
                        .toString()[0]
                        .toUpperCase()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("By:${snapshot.docs[index]['name']} "),
                      Text(dateFormatted),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
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
                                onPressed: () {},
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.purple),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('board')
                            .doc(docId)
                            .delete();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.trashAlt,
                        size: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        //Text(snapshot.docs[index]['title']),
      ],
    );
  }
}
