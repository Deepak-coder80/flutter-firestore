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
                      onPressed: () {},
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
