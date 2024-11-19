
class UserModel {
  String? name;
  String? email;
  String? image;
  String? phone;
  Address? userAddress;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.userAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      userAddress: json['userAddress'] != null ? Address.fromJson(json['userAddress']) : null,

      // userAddress: userAddress!.city
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "userAddress":userAddress
      };
}

class Address {
  String? governorates;
  String? city;

  Address({this.city, this.governorates});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    governorates = json['governorates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['governorates'] = governorates;

    return data;
  }
  
}
