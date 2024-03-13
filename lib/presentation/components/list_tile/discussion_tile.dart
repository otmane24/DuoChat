import 'package:duochat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../constants/strings.dart';

class DiscussionTile extends StatelessWidget {
  final List<MessageModel> messages;
  final int id;
  final String title;
  const DiscussionTile(
      {required this.messages,
      required this.id,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    int vus = 0;
    for (var doc in messages) {
      if (doc.ownerId != usersId[id] && doc.isVus == false) {
        vus++;
      }
    }
    Widget? subtitle = messages.isEmpty
        ? null
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  '${messages[0].ownerId == usersId[id] ? "You: " : ""}${messages[0].message} . ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                DateFormat(messages[0].createdAt!.day == DateTime.now().day &&
                            messages[0].createdAt!.month ==
                                DateTime.now().month &&
                            messages[0].createdAt!.year == DateTime.now().year
                        ? 'HH:mm'
                        : 'EEE')
                    .format(messages[0].createdAt!),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          );
    return ListTile(
      title: Text(title),
      subtitle: subtitle,
      leading: CircleAvatar(
        radius: 32,
        backgroundColor: id == 0
            ? const Color(0xFF9C27B0).withOpacity(.5)
            : Colors.blue.withOpacity(.5),
        child: Text(
          title.characters.first.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      trailing: vus != 0
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text(
                vus.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          : null,
    );
  }
}
