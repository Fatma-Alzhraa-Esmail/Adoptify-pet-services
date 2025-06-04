import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:peto_care/handlers/location_select/model/address_details_model.dart';

abstract class LocationSelect {
 static Future<AddressDetailsModel?> customAddressPicker(BuildContext context) async {
    String googleMapsApiKey = "AIzaSyC55YwtHlB1EnKE_O-kPCZ399GlagquYoY";
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleMapsApiKey,
      onError: (response) => print('Error occured when getting places response:'
          '\n${response.errorMessage}'),
      mode: Mode.overlay,
      types: [],
      components: [],
      strictbounds: false,
      language: "en",
    );

    if (p != null) {
      final placeId = p.placeId;
      if (placeId != null) {
        GoogleMapsPlaces _places = GoogleMapsPlaces(
          apiKey: googleMapsApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(placeId, language: 'en');
        final fullAddress = detail.result.formattedAddress ?? '';

        AddressDetailsModel addressDetails = AddressDetailsModel(
          cityName: detail.result.addressComponents
                  .firstWhereOrNull((e) => e.types.contains('locality'))
                  ?.shortName ??
              detail.result.addressComponents
                  .firstWhereOrNull((e) => e.types.contains('sublocality'))
                  ?.shortName ??
              '',
          stateName: detail.result.addressComponents
                  .firstWhereOrNull(
                      (e) => e.types.contains('administrative_area_level_1'))
                  ?.shortName ??
              '',
          latLng: LatLng(
            latlang: detail.result.geometry?.location.lat ?? 0,
            lattitude: detail.result.geometry?.location.lng ?? 0,
          ),
          fullAddress: fullAddress,
          country:  detail.result.addressComponents
                  .firstWhereOrNull(
                      (e) => e.types.contains('country'))
                  ?.shortName ??
              '',
        );
        print('City: ${addressDetails.cityName}');
        print('State: ${addressDetails.stateName}');
        print('Coordinates: ${addressDetails.latLng}');
        print('Full Address: ${addressDetails.fullAddress}');
        return addressDetails;
      }
    }
  }
}
