import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  num? user_rate;
  String? comment;
  List<String>? images;
  DateTime? created_at;
  String user_id;
  String review_id;

  ReviewModel({
    this.comment,
    this.user_rate,
    this.images,
    this.created_at,
    required this.review_id,
    required this.user_id,

  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      user_rate: json['user_rate'],
      user_id: json['user_id'],
      review_id: json['review_id'],
      images: json['images'] != null
          ? List<String>.from(json['images']) // Ensure this is a List<String>
          : [],
      comment: json['comment'] ?? '',
         created_at: json['created_at'] != null
          ? (json['created_at'] is Timestamp
              ? (json['created_at'] as Timestamp).toDate()
              : DateTime.tryParse(json['created_at'])) // Handle string dates
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_rate": user_rate ?? 0.0,
        "images": images ?? [],
        "comment": comment ?? "",
        "user_id": user_id,
        "review_id": review_id,
         "created_at": created_at != null
          ? Timestamp.fromDate(created_at!) // Convert DateTime to Timestamp
          : FieldValue.serverTimestamp(), // Default to Firestore server time
      };
}
