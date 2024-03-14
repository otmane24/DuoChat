import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionModel {
  final String id;
  final String createdBy;
  final String name;
  final DateTime createdAt;

  factory DiscussionModel.fromJson(QueryDocumentSnapshot json) {
    return DiscussionModel(
      id: json['id'] ?? '',
      createdBy: json['createdBy'] ?? '',
      name: json['name'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'createdBy': createdBy,
        'name': name,
        'createdAt': createdAt,
      };
  DiscussionModel({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.createdAt,
  });
}
