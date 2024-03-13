import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../constants/strings.dart';

class DiscussionNameDialogs extends StatelessWidget {
  final int index;
  final TextEditingController controller = TextEditingController();

  // Constructor for DiscussionNameDialogs
  DiscussionNameDialogs({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Set the title of the AlertDialog
      title: const Text('Enter the name of the discussion'),
      // Set the content of the AlertDialog
      content: TextField(
        // Set the controller of the TextField
        controller: controller,
        // Set the decoration of the TextField
        decoration: const InputDecoration(hintText: "Discussion name"),
      ),
      // Set the actions of the AlertDialog
      actions: <Widget>[
        // Create a TextButton widget
        TextButton(
          // Set the child of the TextButton
          child: const Text('Cancel'),
          // Set the onPressed callback of the TextButton
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
        ),
        // Create a TextButton widget
        TextButton(
          // Set the child of the TextButton
          child: const Text('OK'),
          // Set the onPressed callback of the TextButton
          onPressed: () {
            // If the TextField is not empty
            if (controller.text.isNotEmpty) {
              // Add a new document to the 'Discussion' collection in Firestore
              FirebaseFirestore.instance.collection('Discussion').add({
                'id': const Uuid().v4(),
                'name': controller.text,
                'createdAt': DateTime.now(),
                'createdBy': usersId[index],
              });

              // Close the dialog
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
