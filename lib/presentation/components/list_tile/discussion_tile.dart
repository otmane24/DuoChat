import 'package:duochat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/strings.dart';

class DiscussionTile extends StatelessWidget {
  final List<MessageModel> messages;
  final int id;
  final String title;

  // Constructor for DiscussionTile
  const DiscussionTile(
      {required this.messages,
      required this.id,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize a counter for unread messages
    int vus = 0;
    // Iterate over the messages
    for (var doc in messages) {
      // If the message is not from the current user and has not been read, increment the counter
      if (doc.ownerId != usersId[id] && doc.isVus == false) {
        vus++;
      }
    }
    // Define the subtitle widget
    Widget? subtitle = messages.isEmpty
        ? null
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  // Display the message text, prepending "You: " if the message is from the current user
                  '${messages[0].ownerId == usersId[id] ? "You: " : ""}${messages[0].message} . ',
                  // Limit the text to one line
                  maxLines: 1,
                  // Use an ellipsis to indicate truncated text
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Create a Text widget for the message time
              Text(
                // Format the time based on whether the message was sent today
                DateFormat(messages[0].createdAt!.day == DateTime.now().day &&
                            messages[0].createdAt!.month ==
                                DateTime.now().month &&
                            messages[0].createdAt!.year == DateTime.now().year
                        ? 'HH:mm'
                        : 'EEE')
                    .format(messages[0].createdAt!),
                // Use the small display text style
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          );

    return ListTile(
      title: Text(title),
      subtitle: subtitle,
      leading: CircleAvatar(
        radius: 32,
        // Set the background color of the CircleAvatar based on the id of user
        backgroundColor: id == 0
            ? const Color(0xFF9C27B0).withOpacity(.5)
            : Colors.blue.withOpacity(.5),

        child: Text(
          // Display the first character of the title
          title.characters.first.toUpperCase(),

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
  }
}
