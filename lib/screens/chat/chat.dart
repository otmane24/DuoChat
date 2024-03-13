import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duochat/assistant_methode/firestore_function.dart';
import 'package:duochat/assistant_methode/size_config.dart';
import 'package:duochat/models/message_model.dart';

import 'package:duochat/presentation/components/container/container_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String documentId;
  final String userId;
  final String nameUser;
  ChatScreen(
      {required this.documentId,
      required this.userId,
      required this.nameUser,
      super.key});

  final TextEditingController _textEditingController = TextEditingController();
  final List<MessageModel> messageModel = [];
  final FireStoreFunction fireStoreFunction = FireStoreFunction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStoreFunction.getMessages(documentId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                fireStoreFunction.sendVus(documentId, userId);

                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading ..."));
                }
                messageModel.clear();
                for (var msg in snapshot.data!.docs) {
                  messageModel.add(MessageModel.fromJson(msg));
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return ContainerMessage(
                        message: messageModel[index],
                        isSender: messageModel[index].ownerId == userId);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: .2 * SizeConfig.blockSizeVertical!,
                    );
                  },
                  itemCount: messageModel.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 1.2 * SizeConfig.blockSizeVertical!,
              horizontal: 2 * SizeConfig.blockSizeHorizontal!,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: (value) {
                      if (_textEditingController.text.isNotEmpty) {
                        fireStoreFunction
                            .sendMessage(
                                documentId, userId, _textEditingController.text)
                            .then((value) => _textEditingController.clear());
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      fireStoreFunction
                          .sendMessage(
                              documentId, userId, _textEditingController.text)
                          .then((value) => _textEditingController.clear());
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.purple.withOpacity(.6),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
