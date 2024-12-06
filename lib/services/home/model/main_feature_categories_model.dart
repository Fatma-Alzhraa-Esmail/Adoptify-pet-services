
import 'package:cloud_firestore/cloud_firestore.dart';

class MainFeatureCategoriesModel {
  final String id;
  final String? category_name;
  final String? image;
  final DateTime? created_at;

  MainFeatureCategoriesModel({required this.id, this.category_name, this.image,this.created_at});
  factory MainFeatureCategoriesModel.fromJson(Map<String, dynamic> json) {
    return MainFeatureCategoriesModel(
      id: json['id'] ?? '',
      category_name: json['category_name'],
      image: json['image'],
      created_at: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": category_name,
        "image": image,
        "created_at": created_at != null ? Timestamp.fromDate(created_at!) : null,
      };
}
