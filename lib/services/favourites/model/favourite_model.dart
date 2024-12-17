import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteModel {
  final FeatureType featureType;
  final DocumentReference docRef;
  final DocumentReference? FavouritedocRef;

  FavouriteModel({
    required this.featureType,
    required this.docRef,
    this.FavouritedocRef,
  });

  /// Convert a FavouriteModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'featureType': featureType.name, // Store the enum as a string
      'docRef': docRef, // Store the document path
      'FavouritedocRef': FavouritedocRef, // Store the document path
    };
  }

  /// Create a FavouriteModel instance from JSON
 factory FavouriteModel.fromJson(Map<String, dynamic> json, FirebaseFirestore firestore) {
 
    return FavouriteModel(
      featureType: FeatureType.values.firstWhere(
        (e) => e.name == json['featureType'], // Convert the string back to enum
      ),
      docRef:json['docRef'], // Recreate the DocumentReference
       FavouritedocRef: json['FavouritedocRef'], // Directly use if already a DocumentReference        );
    );
  }
}

/// Enum extension for easier name conversion (optional)
extension FeatureTypeExtension on FeatureType {
  String get name => toString().split('.').last;
}

enum FeatureType {
  Service,
  Tips,
  Shop,
}
