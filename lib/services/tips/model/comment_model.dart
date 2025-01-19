import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final DocumentReference? comment_id;
  final String comment_content;
  List<CommentModel>? replies;
  final int likes_count;
  final List<DocumentReference> likes_accounts;
  final DateTime created_at;
  final DocumentReference? user;
  final bool is_repliy;
  final DocumentReference? repliedOn;

  CommentModel({
    this.comment_id,
    required this.comment_content,
    this.replies,
    required this.likes_count,
    required this.likes_accounts,
    required this.created_at,
    this.user,
    required this.is_repliy,
    this.repliedOn,
  });

  /// Factory method for deserializing JSON
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comment_id: json['comment_id'] != null
          ? json['comment_id'] as DocumentReference
          : null,
      comment_content: json['comment_content'] ?? '',
      replies: json['replies'] != null
          ? (json['replies'] as List<dynamic>)
              .map((replyRef) => CommentModel(
                    comment_id: replyRef as DocumentReference,
                    comment_content:
                        '', // Set to empty initially, will be fetched separately
                    likes_count: 0, // Default value
                    likes_accounts: [], // Default value
                    created_at: DateTime.now(), // Default value
                    is_repliy: false, // Default value
                    user: null, // Default value
                  ))
              .toList()
          : null, // Allow null or empty replies
      likes_count: json['likes_count'] ?? 0,
      likes_accounts: (json['likes_accounts'] as List<dynamic>? ?? [])
          .whereType<DocumentReference>()
          .toList(),
      created_at: json['created_at'] != null
          ? (json['created_at'] is Timestamp
              ? (json['created_at'] as Timestamp).toDate()
              : DateTime.tryParse(json['created_at']) ?? DateTime.now())
          : DateTime.now(),
      user: json['user'] != null ? json['user'] as DocumentReference : null,
      repliedOn: json['repliedOn'] != null ? json['repliedOn'] as DocumentReference : null,
      is_repliy: json['is_repliy'] ?? false,
    );
  }

  /// Method for serializing to JSON
  Map<String, dynamic> toJson() => {
        "comment_id": comment_id,
        "comment_content": comment_content,
        "replies": replies?.map((e) => e.toJson()).toList(),
        "likes_count": likes_count,
        "likes_accounts": likes_accounts.map((e) => e).toList(),
        "created_at": Timestamp.fromDate(created_at),
        "user": user,
        "is_repliy": is_repliy,
        "repliedOn":repliedOn,
      };
}
