import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final DocumentReference productRef;
  final DocumentReference? docRef;
  final String color;
   int count;
  CartModel({
    required this.productRef,
    required this.color,
    required this.count,
    this.docRef,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'docRef': docRef, // Store the document path
      'productRef': productRef, // Store the document path
      'color': color,
      'count':count
    };
  }

  factory CartModel.fromJson(
      Map<String, dynamic> json) {
    return CartModel(
        productRef: json['productRef'], // Recreate the DocumentReference
        docRef: json[
            'docRef'], // Directly use if already a DocumentReference        );
        color: json['color'],
        
        count: json['count'],
        );
  }

}
