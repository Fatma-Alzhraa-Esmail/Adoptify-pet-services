
import 'package:cloud_firestore/cloud_firestore.dart';

class MainFeaturesModel {
  final String id;
  final String? main_feature_name;
  final String? image;
  final DateTime? created_at;

  MainFeaturesModel({required this.id, this.main_feature_name, this.image,this.created_at});
  factory MainFeaturesModel.fromJson(Map<String, dynamic> json) {
    return MainFeaturesModel(
      id: json['id']??'',
      main_feature_name: json['main_feature_name'],
      image: json['image'],
      created_at: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "main_feature_name": main_feature_name,
        "image": image,
        "created_at": created_at != null ? Timestamp.fromDate(created_at!) : null,
      };
}
