import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duochat/utils/firestore_function.dart';
import 'package:duochat/utils/size_config.dart';
import 'package:duochat/models/discussion_model.dart';
import 'package:duochat/presentation/components/list_tile/discussion_tile.dart';
import 'package:duochat/presentation/constants/strings.dart';
import 'package:duochat/routing/app_routing.dart';
import 'package:flutter/material.dart';

class DiscussionScreen extends StatefulWidget {
  // Declare the id and initialize the messageModel and discussionModel lists
  final int id;

  const DiscussionScreen({required this.id, super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final List<DiscussionModel> discussionModel = [];

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
                        snapshot.data!.docs[index].id, // the discussion id
                        usersId[widget.id], // the user id
                        "User ${widget.id == 0 ? 2 : 1}" // to know which user you are talking to
                      ]).then((value) => setState(() {})), //

                      child: DiscussionTile(
                        documentId: snapshot.data!.docs[index]
                            .id, // the messageModel list to know the last message and number of new messages
                        id: widget.id, // the user id
                        title:
                            discussionModel[index].name, // the discussion name
                      ),
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
