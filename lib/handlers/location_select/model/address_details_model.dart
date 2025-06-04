class AddressDetailsModel {
  final String? cityName;
  final String? stateName;
  final LatLng? latLng;
  final String? fullAddress;
  final String? country;

  AddressDetailsModel({ this.cityName,  this.stateName,  this.latLng,  this.fullAddress,this.country});
}
class LatLng{
    final double? latlang;
  final double? lattitude;

  LatLng({ this.latlang,  this.lattitude});
}

