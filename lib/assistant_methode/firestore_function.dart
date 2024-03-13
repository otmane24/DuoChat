import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../presentation/constants/strings.dart';

class FireStoreFunction {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();
  Future<void> checkUser() async {
    const documentId = 'x6JUI2HBrSu5QTXrIi6Q';
    final userRef = firestore.collection('Users').doc(documentId);
    final doc = await userRef.get();

    if (doc.data()!.isEmpty) {
      usersId.addAll([_uuid.v4(), _uuid.v4()]);

      await userRef.set({
        'ids': usersId,
      });
    } else {
      usersId.addAll(List<String>.from(doc.data()!['ids']));
    }
  }

  getMessages(String documentId) {
    return firestore
        .collection('Discussion')
        .doc(documentId)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  getDiscussion() {
    return firestore
        .collection('Discussion')
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String documentId, String userId, String msg) async {
    DocumentReference document =
        FirebaseFirestore.instance.collection('Discussion').doc(documentId);
    document.collection("messages").add({
      "createdAt": DateTime.now(),
      "isVus": false,
      "ownerId": userId,
      "message": msg
    });
  }

  sendVus(String documentId, String userId) {
    final collection = FirebaseFirestore.instance
        .collection('Discussion')
        .doc(documentId)
        .collection('messages');

    collection.get().then((element) {
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
