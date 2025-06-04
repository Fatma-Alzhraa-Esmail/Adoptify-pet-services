import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String? id; // Changed from DocumentReference? to String?
  final String? name;
  final String? location;
  final String? phoneNumber;
  final String? countryCode;
  final String? dialCode;
  final String? city;
  final String? country;
  final double latitude; // Latitude field
  final double longitude; // Longitude field
  final DateTime? updated_at;

  AddressModel({
    this.id,
    this.name,
    this.location,
    this.phoneNumber,
    this.countryCode,
    this.dialCode,
    this.city,
    this.country,
    required this.latitude,
    required this.longitude,
    required this.updated_at,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String?, // Changed to String? cast
      name: json['name'] as String?,
      location: json['location'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      dialCode: json['dialCode'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      latitude:
          (json['latitude'] as num?)?.toDouble() ?? 0.0, // Handle null or int
      longitude:
          (json['longitude'] as num?)?.toDouble() ?? 0.0, // Handle null or int

      updated_at: json['updated_at'] != null
          ? (json['updated_at'] is Timestamp
              ? (json['updated_at'] as Timestamp).toDate()
              : DateTime.tryParse(json['updated_at'])) // Handle string dates
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "dialCode": dialCode,
        "city": city,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "updated_at": updated_at != null
            ? Timestamp.fromDate(updated_at!) // Convert DateTime to Timestamp
            : FieldValue.serverTimestamp(), // Default to Firestore server time
      };
}
