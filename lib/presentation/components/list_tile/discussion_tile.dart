import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duochat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/firestore_function.dart';
import '../../constants/strings.dart';

class DiscussionTile extends StatefulWidget {
  final String documentId;
  final int id;
  final String title;

  // Constructor for DiscussionTile
  const DiscussionTile(
      {required this.documentId,
      required this.id,
      required this.title,
      super.key});

  @override
  State<DiscussionTile> createState() => _DiscussionTileState();
}

class _DiscussionTileState extends State<DiscussionTile> {
  final List<MessageModel> messageModel = [];
  checkDateOfMessage() {
    if (messageModel[0].createdAt.day == DateTime.now().day &&
        messageModel[0].createdAt.month == DateTime.now().month &&
        messageModel[0].createdAt.year == DateTime.now().year) {
      return 'HH:mm';
    } else {
      return 'EEE';
    }
  }

  // Initialize a counter for unread messages
  int vus = 0;
  Widget? subtitle;
  @override
  void initState() {
    // Iterate over the messages

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireStoreFunction().getMessages(
          widget.documentId,
        ),
        builder: (context, snapshot2) {
          if (snapshot2.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot2.connectionState == ConnectionState.waiting) {
            return const Text("");
          }
          // Clear the messageModel list
          messageModel.clear();
          // Add each document in the snapshot to the messageModel list
          for (var msg in snapshot2.data!.docs) {
            messageModel.add(MessageModel.fromJson(msg));
          }
          for (var doc in messageModel) {
            // If the message is not from the current user and has not been read, increment the counter
            if (doc.ownerId != usersId[widget.id] && doc.isSeen == false) {
              vus++;
            }
          }
          subtitle = messageModel.isEmpty
              ? null
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        // Display the message text, prepending "You: " if the message is from the current user
                        '${messageModel[0].ownerId == usersId[widget.id] ? "You: " : ""}${messageModel[0].message} . ',
                        // Limit the text to one line
                        maxLines: 1,
                        // Use an ellipsis to indicate truncated text
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Create a Text widget for the message time
                    Text(
                      // Format the time based on whether the message was sent today
                      DateFormat(checkDateOfMessage())
                          .format(messageModel[0].createdAt),
                    ),
                  ],
                );
          //
          return ListTile(
            title: Text(widget.title),
            subtitle: subtitle,
            leading: CircleAvatar(
              radius: 32,
              // Set the background color of the CircleAvatar based on the id of user
              backgroundColor: widget.id == 0
                  ? const Color(0xFF9C27B0).withOpacity(.5)
                  : Colors.blue.withOpacity(.5),

              child: Text(
                // Display the first character of the title
                widget.title.characters.first.toUpperCase(),

                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            trailing: vus != 0
                ? CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Text(
                      // Display the number of unread messages
                      vus.toString(),
                      // Use a white, small text style
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                : null,
          );
        });
  }
}
