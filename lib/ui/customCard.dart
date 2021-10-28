// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  const CardView({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(snapshot.docs[index]['title']),
          subtitle: Text(snapshot.docs[index]['description']),
          leading: CircleAvatar(
            radius: 34,
            child:
                Text(snapshot.docs[index]['title'].toString()[0].toUpperCase()),
          ),
        )
        //Text(snapshot.docs[index]['title']),
      ],
    );
  }
}
