import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionModel {
  String? id;
  String? createdBy;
  String? name;
  DateTime? createdAt;

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
    this.id,
    this.createdBy,
    this.name,
    this.createdAt,
  });
}
