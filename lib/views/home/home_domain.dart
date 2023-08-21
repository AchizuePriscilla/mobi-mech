import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobi_mech/data/remote/google_map_apis/google_map_service.dart';
import 'package:mobi_mech/models/place_model.dart';

class HomeDomain {
  late final GoogleMapServices _mapServices;
  HomeDomain({required GoogleMapServices mapServices})
      : _mapServices = mapServices;
  final ValueNotifier<bool> _fetchingMechanics = ValueNotifier(false);
  ValueNotifier<bool> get fetchingMechanics => _fetchingMechanics;

  final ValueNotifier<List<PlaceModel>> _mechanics = ValueNotifier([]);
  ValueNotifier<List<PlaceModel>> get mechanics => _mechanics;

  final ValueNotifier<bool> _fetchingTopRated = ValueNotifier(false);
  ValueNotifier<bool> get fetchingTopRated => _fetchingTopRated;

  final ValueNotifier<List<PlaceModel>> _topRatedMechanics = ValueNotifier([]);
  ValueNotifier<List<PlaceModel>> get topRatedMechanics => _topRatedMechanics;

  final ValueNotifier<bool> _fetchingLocations = ValueNotifier(false);
  ValueNotifier<bool> get fetchingLocations => _fetchingLocations;
  final ValueNotifier<List<PlaceModel>> _locations = ValueNotifier([]);
  ValueNotifier<List<PlaceModel>> get locations => _locations;
  void _setFetchingMechanics(bool val) {
    if (_fetchingMechanics.value != val) {
      _fetchingMechanics.value = val;
    }
  }

  void _setFetchingLocations(bool val) {
    if (_fetchingLocations.value != val) {
      _fetchingLocations.value = val;
    }
  }

  void _setFetchingTopRated(bool val) {
    if (_fetchingTopRated.value != val) {
      _fetchingTopRated.value = val;
    }
  }

  Future<void> getTopRatedMechanics(LatLng latLng) async {
    try {
      _setFetchingTopRated(true);
      var response = await _mapServices.searchMechanics(latLng);
      if (response.success) {
        _topRatedMechanics.value = response.data!;
      }
      _setFetchingTopRated(false);
    } catch (e) {
      _setFetchingTopRated(false);
    }
    _setFetchingTopRated(false);
  }

  Future<void> getNearbyMechanics(LatLng latng) async {
    try {
      _setFetchingMechanics(true);
      var response = await _mapServices.searchMechanics(latng);
      if (response.success) {
        _mechanics.value = response.data!;
        _locations.value = [];
      }
      _setFetchingMechanics(false);
    } catch (e) {
      _setFetchingMechanics(false);
    }
    _setFetchingMechanics(false);
  }

  Future<void> locationSearchResults(String query, String sessiontoken) async {
    try {
      _setFetchingLocations(true);
      var response =
          await _mapServices.searchLocationsUsingQueryText(query, sessiontoken);
      if (response.success) {
        _locations.value = response.data!;
      }
      _setFetchingLocations(false);
    } catch (e) {
      _setFetchingLocations(false);
    }
    _setFetchingLocations(false);
  }
}
