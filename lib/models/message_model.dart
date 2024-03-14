import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String ownerId;
  final bool isSeen;
  final DateTime createdAt;

  // Define a factory constructor that creates a MessageModel from a JSON object
  factory MessageModel.fromJson(QueryDocumentSnapshot json) {
    return MessageModel(
      message: json['message'] ?? '',
      ownerId: json['ownerId'] ?? '',
      isSeen: json['isSeen'] ?? false,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'ownerId': ownerId,
        'isSeen': isSeen,
        'createdAt': createdAt,
      };

  MessageModel({
    required this.message,
    required this.ownerId,
    required this.isSeen,
    required this.createdAt,
  });
}
