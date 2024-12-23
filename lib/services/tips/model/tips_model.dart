import 'package:cloud_firestore/cloud_firestore.dart';

class TipsModel {
  final DocumentReference docRef;
  final String? title;
  final String? subTitle;
  final String? description;
  final String? image;
  final String? status;
  final bool? isHighlight;
  final DateTime? created_at;

  TipsModel({
    required this.docRef,
    this.title,
    this.subTitle,
    this.description,
    this.image,
    this.status,
    this.isHighlight,
    required this.created_at,
  });

  factory TipsModel.fromJson(Map<String, dynamic> json) {
    return TipsModel(
      docRef: json['docRef'],
      description: json['description'],
      status: json['status'],
      subTitle: json['subTitle'],
      title: json['title'],
      image: json['image'],
      created_at: json['created_at'] != null
          ? (json['created_at'] is Timestamp
              ? (json['created_at'] as Timestamp).toDate()
              : DateTime.tryParse(json['created_at'])) // Handle string dates
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "docRef": docRef  ,
        "description": description ?? "",
        "status": status ?? "",
        "subTitle": subTitle ?? "",
        "title": title ?? "",
        "image": image ?? "",
        "created_at": created_at != null
            ? Timestamp.fromDate(created_at!) // Convert DateTime to Timestamp
            : FieldValue.serverTimestamp(), // Default to Firestore server time
      };
}
