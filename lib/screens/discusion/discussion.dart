import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duochat/assistant_methode/firestore_function.dart';
import 'package:duochat/assistant_methode/size_config.dart';
import 'package:duochat/models/discussion_model.dart';
import 'package:duochat/presentation/components/list_tile/discussion_tile.dart';
import 'package:duochat/presentation/constants/strings.dart';
import 'package:duochat/routing/app_routing.dart';
import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class DiscussionScreen extends StatelessWidget {
  // Declare the id and initialize the messageModel and discussionModel lists
  final int id;
  final List<MessageModel> messageModel = [];
  final List<DiscussionModel> discussionModel = [];

  DiscussionScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        // Set the stream to get the discussion from Firestore
        stream: FireStoreFunction().getDiscussion(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // If the snapshot has an error, return a Text widget with an error message
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          // If the snapshot is still loading, return a Center widget with a loading message
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading ..."));
          }
          // Clear the discussionModel list
          discussionModel.clear();

          // Add each document in the snapshot to the discussionModel list
          for (var discu in snapshot.data!.docs) {
            discussionModel.add(DiscussionModel.fromJson(discu));
          }
          // If the snapshot is empty, return a Center widget with a message
          // Otherwise, return a ListView.separated widget to display the discussions
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
                      // Set the onTap callback to navigate to the chat screen
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRouter.chatScreenRouter, arguments: [
                        discussionModel[index].id, // the discussion id
                        usersId[id], // the user id
                        "User ${id == 0 ? 2 : 1}" // to know which user you are talking to
                      ]), //

                      child: StreamBuilder<QuerySnapshot>(
                          stream: FireStoreFunction().getMessages(discussionModel[
                                  index]
                              .id!), // Set the stream to get the messages from Firestore

                          builder: (context, snapshot2) {
                            if (snapshot2.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("");
                            }
                            // Clear the messageModel list
                            messageModel.clear();
                            // Add each document in the snapshot to the messageModel list
                            for (var msg in snapshot2.data!.docs) {
                              messageModel.add(MessageModel.fromJson(msg));
                            }
                            // Return a DiscussionTile widget
                            return DiscussionTile(
                              messages:
                                  messageModel, // the messageModel list to know the last message and number of new messages
                              id: id, // the user id
                              title:
                                  '${discussionModel[index].name}', // the discussion name
                            );
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
                  // Set the itemCount of the ListView
                  itemCount: discussionModel.length,
                );
        },
      ),
    );
  }
}
