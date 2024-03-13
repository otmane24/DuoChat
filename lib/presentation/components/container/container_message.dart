import 'package:duochat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../assistant_methode/size_config.dart';
import '../../colors/color_manager.dart';

class ContainerMessage extends StatelessWidget {
  final MessageModel message;
  final bool isSender;

  const ContainerMessage(
      {required this.message, required this.isSender, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 2 * SizeConfig.blockSizeHorizontal!,
            vertical: SizeConfig.blockSizeVertical!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: isSender
              ? [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: 80 * SizeConfig.blockSizeHorizontal!),
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.8 * SizeConfig.blockSizeHorizontal!,
                        vertical: .8 * SizeConfig.blockSizeVertical!),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: SelectableText(
                            message.message!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(
                          width: 1.2 * SizeConfig.blockSizeHorizontal!,
                        ),
                        Text(
                          DateFormat('kk:mm').format(message.createdAt!),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(
                          width: 1.2 * SizeConfig.blockSizeHorizontal!,
                        ),
                        Icon(
                          Icons.done_all,
                          size: 3.4 * SizeConfig.blockSizeHorizontal!,
                          color: message.isVus!
                              ? ColorManager.primary
                              : ColorManager.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2 * SizeConfig.blockSizeHorizontal!,
                  ),
                  CircleAvatar(
                    radius: SizeConfig.blockSizeVertical!,
                    backgroundColor: Colors.blueAccent.withOpacity(0.9),
                  ),
                ]
              : [
                  CircleAvatar(
                    radius: SizeConfig.blockSizeVertical!,
                    backgroundColor: Colors.redAccent.withOpacity(0.9),
                  ),
                  SizedBox(
                    width: 2 * SizeConfig.blockSizeHorizontal!,
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: 80 * SizeConfig.blockSizeHorizontal!),
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.8 * SizeConfig.blockSizeHorizontal!,
                        vertical: .8 * SizeConfig.blockSizeVertical!),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(.15),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: SelectableText(
                            message.message!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(
                          width: 2 * SizeConfig.blockSizeHorizontal!,
                        ),
                        Text(
                          DateFormat('kk:mm').format(message.createdAt!),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
