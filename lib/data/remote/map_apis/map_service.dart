import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobi_mech/data/remote/map_apis/map_repo.dart';
import 'package:mobi_mech/models/api/general_response.dart';
import 'package:mobi_mech/models/api/place_response.dart';
import 'package:mobi_mech/models/api/places_response.dart';
import 'package:mobi_mech/models/place_model.dart';

abstract class MapServices {
  Future<PlacesResponse> reverseGeocodeUsingLatLng(LatLng latLng);
  Future<GeneralResponse<List<PlaceModel>>> searchLocationsUsingQueryText(
      String query, String sessiontoken);
  Future<GeneralResponse<List<PlaceModel>>> searchMechanics(LatLng latLng);
  Future<PlaceResponse> getPlaceDetails(String placeId, sessiontoken);
}

class MapServicesImpl implements MapServices {
  final MapRepository mapRepository;

  MapServicesImpl({required this.mapRepository});
  @override
  Future<PlacesResponse> reverseGeocodeUsingLatLng(LatLng latLng) async {
    var res = await mapRepository.reverseGeocodeUsingLatLng(latLng);
    return res;
  }

  @override
  Future<GeneralResponse<List<PlaceModel>>> searchLocationsUsingQueryText(
      String query, String sessiontoken) async {
    var res =
        await mapRepository.searchLocationsUsingQueryText(query, sessiontoken);
    return res;
  }

  @override
  Future<GeneralResponse<List<PlaceModel>>> searchMechanics(
      LatLng latLng) async {
    var res = await mapRepository.searchMechanics(latLng);
    return res;
  }
  
  @override
  Future<PlaceResponse> getPlaceDetails(String placeId, sessiontoken) async{
     var res = await mapRepository.getPlaceDetails(placeId, sessiontoken);
    return res;
  }
}
