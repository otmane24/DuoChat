import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../constants/strings.dart';

class DiscussionNameDialogs extends StatelessWidget {
  final int index;
  DiscussionNameDialogs({required this.index, super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter the name of the discussion'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Discussion name"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              FirebaseFirestore.instance.collection('Discussion').add({
                'id': const Uuid().v4(),
                'name': controller.text,
                'createdAt': DateTime.now(),
                'createdBy': usersId[index],
              });

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
