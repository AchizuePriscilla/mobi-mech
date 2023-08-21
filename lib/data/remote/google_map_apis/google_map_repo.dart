import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobi_mech/data/config/base_api.dart';
import 'package:mobi_mech/models/api/general_response.dart';
import 'package:mobi_mech/models/api/place_response.dart';
import 'package:mobi_mech/models/api/places_response.dart';
import 'package:mobi_mech/models/place_model.dart';
import 'package:mobi_mech/utils/constants.dart';
import 'package:mobi_mech/utils/parser_util.dart';

abstract class GoogleMapRepository {
  Future<PlacesResponse> reverseGeocodeUsingLatLng(LatLng latLng);
  Future<GeneralResponse<List<PlaceModel>>> searchLocationsUsingQueryText(
      String query, sessiontoken);
  Future<GeneralResponse<List<PlaceModel>>> searchMechanics(LatLng latLng);
  Future<PlaceResponse> getPlaceDetails(String placeId, sessiontoken);
}

class GoogleMapRepositoryImpl extends BaseApi implements GoogleMapRepository {
  GoogleMapRepositoryImpl(String baseApi) : super(baseApi);
  static String reverseGeocode = 'geocode/json?';
  static String searchByText = 'place/autocomplete/json?';
  static String nearbySearch = 'place/nearbysearch/json?';
  static String placeDetails = 'place/details/json?';

  @override
  Future<PlacesResponse> reverseGeocodeUsingLatLng(LatLng latLng) async {
    var response = await get(
        "$reverseGeocode&latlng=6.868820929766292,7.39536727941966&key=$apiKey");

    return PlacesResponse.fromMap(response);
  }

  @override
  Future<GeneralResponse<List<PlaceModel>>> searchLocationsUsingQueryText(
      String query, sessiontoken) async {
    var response = await get(
        "$searchByText&input=$query&inputtype=textquery&fields=name&locationbias=circle:100000@6.459964,7.548949&sessiontoken=$sessiontoken&key=$apiKey");

    return GeneralResponse<List<PlaceModel>>.fromMap(
      response,
      parseJson: (json) => ParserUtil<PlaceModel>().parseJsonList(
        json: json["predictions"],
        fromJson: (data) => PlaceModel.fromJson(data),
      ),
    );
  }

  @override
  Future<PlaceResponse> getPlaceDetails(String placeId, sessiontoken) async {
    var response = await get(
        "$placeDetails&place_id=$placeId&fields=geometry&sessiontoken=$sessiontoken&key=$apiKey");

    return PlaceResponse.fromMap(response);
  }

  @override
  Future<GeneralResponse<List<PlaceModel>>> searchMechanics(
      LatLng latLng) async {
    var response = await get(
        "$nearbySearch&location=6.868820929766292,7.39536727941966&radius=50000&type=car_repair&key=$apiKey");

    return GeneralResponse<List<PlaceModel>>.fromMap(
      response,
      parseJson: (json) => ParserUtil<PlaceModel>().parseJsonList(
        json: json["results"],
        fromJson: (data) => PlaceModel.fromJson(data),
      ),
    );
  }
}
