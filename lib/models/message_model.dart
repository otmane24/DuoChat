import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  String? ownerId;
  bool? isVus;
  DateTime? createdAt;

  // Define a factory constructor that creates a MessageModel from a JSON object
  factory MessageModel.fromJson(QueryDocumentSnapshot json) {
    return MessageModel(
      message: json['message'] ?? '',
      ownerId: json['ownerId'] ?? '',
      isVus: json['isVus'] ?? false,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'ownerId': ownerId,
        'isVus': isVus,
        'createdAt': createdAt,
      };

  MessageModel({
    this.message,
    this.ownerId,
    this.isVus,
    this.createdAt,
  });
}
