import 'package:duochat/models/message_model.dart';
import 'package:duochat/presentation/components/container/container_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/size_config.dart';
import '../../colors/color_manager.dart';

class MessageItem extends StatelessWidget {
  // Declare variables to hold the message and sender status
  final MessageModel message;
  final bool isSender;

  // Constructor for MessageItem
  const MessageItem({required this.message, required this.isSender, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      // Set the alignment based on whether the message is sent by the current user
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,

      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 2 * SizeConfig.blockSizeHorizontal!,
            vertical: SizeConfig.blockSizeVertical!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          // Set the children of the Row widget based on whether the message is sent by the current user
          children: isSender
              ? [
                  // Create a ContainerMessage widget for the message
                  ContainerMessage(
                    children: [
                      // Create a Flexible widget for the message text
                      Flexible(
                        child: SelectableText(
                          message.message!,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: 1.2 * SizeConfig.blockSizeHorizontal!,
                      ),
                      // Create a Text widget for the message time
                      Text(
                        DateFormat('hh:mm').format(message.createdAt!),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 1.2 * SizeConfig.blockSizeHorizontal!,
                      ),
                      // Create an Icon widget for the message status
                      Icon(
                        Icons.done_all,
                        size: 3.4 * SizeConfig.blockSizeHorizontal!,
                        color: message.isSeen!
                            ? ColorManager.primary
                            : ColorManager.grey,
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 2 * SizeConfig.blockSizeHorizontal!,
                  ),
                  // Create a CircleAvatar widget for the user avatar
                  CircleAvatar(
                    radius: SizeConfig.blockSizeVertical!,
                    backgroundColor: Colors.blueAccent.withOpacity(0.9),
                  ),
                ]
              : [
                  // Create a CircleAvatar widget for the user avatar
                  CircleAvatar(
                    radius: SizeConfig.blockSizeVertical!,
                    backgroundColor: Colors.redAccent.withOpacity(0.9),
                  ),
                  SizedBox(
                    width: 2 * SizeConfig.blockSizeHorizontal!,
                  ),
                  // Create a ContainerMessage widget for the message
                  ContainerMessage(
                    children: [
                      // Create a Flexible widget for the message text
                      Flexible(
                        child: SelectableText(
                          message.message!,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: 2 * SizeConfig.blockSizeHorizontal!,
                      ),
                      // Create a Text widget for the message time
                      Text(
                        DateFormat('hh:mm').format(message.createdAt!),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],
        ),
      ),
    );
  }
}
