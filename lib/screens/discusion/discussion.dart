import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duochat/assistant_methode/firestore_function.dart';
import 'package:duochat/assistant_methode/size_config.dart';
import 'package:duochat/models/discussion_model.dart';
import 'package:duochat/presentation/components/list_tile/discussion_tile.dart';
import 'package:duochat/presentation/constants/strings.dart';
import 'package:duochat/routing/app_routing.dart';
import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class Discussion extends StatelessWidget {
  final int id;
  Discussion({required this.id, super.key});
  final List<MessageModel> messageModel = [];
  final List<DiscussionModel> discussionModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreFunction().getDiscussion(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading ..."));
          }
          discussionModel.clear();
          for (var discu in snapshot.data!.docs) {
            discussionModel.add(DiscussionModel.fromJson(discu));
          }
          return snapshot.data!.docs.isEmpty
              ? const Center(
                  child: Text(
                      "Click on the + button to generate a new discussion"),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                      vertical: 2 * SizeConfig.blockSizeVertical!),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRouter.chatScreenRouter, arguments: [
                        discussionModel[index].id,
                        usersId[id],
                        "User ${id == 0 ? 2 : 1}"
                      ]), //
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FireStoreFunction()
                              .getMessages(discussionModel[index].id!),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("");
                            }
                            messageModel.clear();
                            for (var msg in snapshot2.data!.docs) {
                              messageModel.add(MessageModel.fromJson(msg));
                            }
                            return DiscussionTile(
                                messages: messageModel,
                                id: id,
                                title: '${discussionModel[index].name}');
                          }),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeVertical! * 2),
                      child: const Divider(),
                    );
                  },
                  itemCount: discussionModel.length,
                );
        },
      ),
    );
  }
}
