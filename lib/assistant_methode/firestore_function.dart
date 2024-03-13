import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../presentation/constants/strings.dart';

class FireStoreFunction {
  // Initialize a Firestore instance
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Initialize a UUID instance
  final _uuid = const Uuid();

  // Define a method to get users
  Future<void> getUsers() async {
    // Define the document ID,it fixed to get ever time the same users Id
    const documentId = 'x6JUI2HBrSu5QTXrIi6Q';
    // Get a reference to the user document
    final userRef = firestore.collection('Users').doc(documentId);
    // Get the user document
    final doc = await userRef.get();

    // Check if the user document is empty
    if (doc.data()!.isEmpty) {
      // If it's empty, add two new UUIDs to the users ID list
      usersId.addAll([_uuid.v4(), _uuid.v4()]);

      // Set the users ID list in the user document
      await userRef.set({
        'ids': usersId,
      });
    } else {
      // If it's not empty, add the existing IDs to the users ID list
      usersId.addAll(List<String>.from(doc.data()!['ids']));
    }
  }

  // Define a method to get messages
  getMessages(String documentId) {
    // Return a stream of message documents, ordered by creation time in descending order
    return firestore
        .collection('Discussion')
        .doc(documentId)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  // Define a method to get discussions
  getDiscussion() {
    // Return a stream of discussion documents, ordered by creation time in descending order
    return firestore
        .collection('Discussion')
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  // Define a method to send a message
  Future<void> sendMessage(String documentId, String userId, String msg) async {
    // Get a reference to the discussion document
    DocumentReference document =
        FirebaseFirestore.instance.collection('Discussion').doc(documentId);
    // Add a new message to the discussion document
    document.collection("messages").add({
      "createdAt": DateTime.now(),
      "isVus": false,
      "ownerId": userId,
      "message": msg
    });
  }

  // Define a method to send a 'vus' (viewed) status
  sendVus(String documentId, String userId) {
    // Get a reference to the messages collection
    final collection = FirebaseFirestore.instance
        .collection('Discussion')
        .doc(documentId)
        .collection('messages');

    // Get all the messages
    collection.get().then((element) {
      // For each message, if the owner is not the current user, update the 'vus' status to true
      for (var doc in element.docs) {
        if (doc['ownerId'] != userId) {
          doc.reference.update({
            'isVus': true,
          });
        }
      }
    });
  }
}