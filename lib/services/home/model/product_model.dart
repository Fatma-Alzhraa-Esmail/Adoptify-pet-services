import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peto_care/services/shop_product_details/model/review_model.dart';

class ProductModel {
  final String id;
  final String mainFeaturesId;
  final String mainFeatureCategoryId;
  final DocumentReference docRef;
  final String? product_name;
  final String? service_name;
  final DateTime? created_at;
  final String? description;
  final List<ColorsModel>? colors;
  final num? discount;
  final num? price;
  final num? discountDuration;
  final List<String>? productInfo;
  final RatingModel? rating;
  final DateTime? offer_end_date;
  final List<ReviewModel>? ReviewList;


  ProductModel({
    required this.id,
    required this.mainFeatureCategoryId,
    required this.mainFeaturesId,
    required this.docRef,
    
    this.product_name,
    this.created_at,
    this.description,
    this.colors,
    this.discount,
    this.price,
    this.productInfo,
    this.rating,
    this.service_name,
    this.discountDuration,
    this.offer_end_date,
    this.ReviewList
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] ?? '',
        docRef: json['docRef'] ?? '',
        mainFeatureCategoryId: json['mainFeatureCategoryId'] ?? '',
        mainFeaturesId: json['mainFeaturesId'] ?? '',
        product_name: json['product_name'] ?? '',
        service_name: json['service_name'] ?? '',
        description: json['description'] ?? '',
        created_at: json['created_at'] != null
            ? (json['created_at'] as Timestamp).toDate()
            : null,
        offer_end_date: json['offer_end_date'] != null
            ? (json['offer_end_date'] as Timestamp).toDate()
            : null,
        // Convert List<dynamic> to List<String> for productInfo
        productInfo: json['productInfo'] != null
            ? List<String>.from(
                json['productInfo'].map((item) => item.toString()))
            : [],
        colors: json['colors'] != null
            ? List<ColorsModel>.from(
                json['colors']
                    .map((colorJson) => ColorsModel.fromJson(colorJson)),
              )
            : [],
             ReviewList: json['ReviewList'] != null
            ? List<ReviewModel>.from(
                json['ReviewList']
                    .map((reviewJson) => ReviewModel.fromJson(reviewJson)),
              )
            : [],
        discount: json['discount'] ?? 0,
        price: json['price'] ?? 0.0,
        rating: json['rating'] != null
            ? RatingModel.fromJson(json['rating'])
            : null,
        discountDuration: json['discountDuration'] ?? 0.0);
  }
}

class ColorsModel {
  String? color;
  List<String>? images;

  ColorsModel({
    this.color,
    this.images,
  });

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      color: json['color'],
      images: json['images'] != null
          ? List<String>.from(json['images']) // Ensure this is a List<String>
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "color": color ?? '000000',
        "images": images ?? [],
      };
}

class RatingModel {
  num? rate;
  num? rate_count;
  RatingModel({
    this.rate,
    this.rate_count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate'],
      rate_count: json['rate_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        "rate": rate ?? 0.0,
        "rate_count": rate_count ?? 0,
      };
}
