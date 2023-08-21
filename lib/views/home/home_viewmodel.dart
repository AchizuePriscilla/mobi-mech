import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobi_mech/core/base_viewmodel.dart';
import 'package:mobi_mech/models/place_model.dart';
import 'package:mobi_mech/utils/constants.dart';
import 'package:mobi_mech/utils/locator.dart';
import 'package:mobi_mech/utils/logger.dart';
import 'package:mobi_mech/views/home/home_domain.dart';

class HomeVM extends BaseViewModel {
  List<PlaceModel> mechanics = [];
  List<PlaceModel> locations = [];
  List<PlaceModel> topRated = [];
  late HomeDomain _homeDomain;
  HomeVM({HomeDomain? homeDomain}) {
    _homeDomain = homeDomain ?? locator();
    _addListener();
  }
  void _addListener() {
    mechanics = _mechanics.value;
    locations = _locations.value;
    topRated = _topRated.value;
    _mechanics.addListener(() {
      _fetchingMechanics =
          _homeDomain.fetchingMechanics.value || _mechanics.value.isEmpty;
      mechanics = _mechanics.value;
      mechanics.retainWhere((element) => element.photoUrl!.isNotEmpty);
      notifyListeners();
    });
    _topRated.addListener(() {
      _fetchingTopRated =
          _homeDomain.fetchingTopRated.value || _topRated.value.isEmpty;
      topRated = _topRated.value;
      _organizebyTopRated();
      notifyListeners();
    });
    _locations.addListener(() {
      _fetchingLocations =
          _homeDomain.fetchingLocations.value || _locations.value.isEmpty;
      locations = _locations.value;
      notifyListeners();
    });
    _homeDomain.fetchingMechanics.addListener(() {
      _fetchingMechanics = _homeDomain.fetchingMechanics.value ||
          _homeDomain.mechanics.value.isEmpty;
      notifyListeners();
    });
    _homeDomain.fetchingLocations.addListener(() {
      _fetchingLocations = _homeDomain.fetchingLocations.value ||
          _homeDomain.locations.value.isEmpty;
      notifyListeners();
    });
    _homeDomain.fetchingTopRated.addListener(() {
      _fetchingTopRated = _homeDomain.fetchingTopRated.value ||
          _homeDomain.topRatedMechanics.value.isEmpty;
      notifyListeners();
    });
  }

  ValueNotifier<List<PlaceModel>> get _mechanics => _homeDomain.mechanics;
  ValueNotifier<List<PlaceModel>> get _locations => _homeDomain.locations;

  ValueNotifier<List<PlaceModel>> get _topRated =>
      _homeDomain.topRatedMechanics;

  bool _fetchingMechanics = false;
  bool get fetchingMechanics => _fetchingMechanics;
  bool _fetchingTopRated = false;
  bool get fetchingTopRated => _fetchingTopRated;
  bool _fetchingLocations = false;
  bool get fetchingLocations => _fetchingLocations;
  void _organizebyTopRated() {
    topRated.retainWhere((element) => element.photoUrl!.isNotEmpty);
    topRated.sort((b, a) {
      int cmp = a.rating!.compareTo(b.rating!);
      if (cmp == 0) {
        return a.userRatingstotal!.compareTo(b.userRatingstotal!);
      } else {
        return cmp;
      }
    });

    notifyListeners();
  }

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    try {
      LocationData locationData = await location.getLocation();
      LatLng currentLocation =
          const LatLng(6.868820929766292, 7.39536727941966);
      // Get the current user address
      var res =
          await googleMapServices.reverseGeocodeUsingLatLng(currentLocation);
      if (res.success) {
        String currentAddress = res.placeModel!.formattedAddress!;

        // Store the user location in sharedPreferences
        await localCache.saveToLocalCache(
            key: kLatitude, value: locationData.latitude!);
        await localCache.saveToLocalCache(
            key: kLongitude, value: locationData.longitude!);
        await localCache.saveToLocalCache(
            key: kCurrentAddress, value: currentAddress);
        localCache.getCurrentLatLngFromSharedPrefs();
      } else {
        AppLogger.log(res.error!.message);
      }
    } catch (e) {
      AppLogger.log(e);
    }
    // Get the current user location
  }

  void toggleFetchingMechanocs(bool val) {
    _fetchingMechanics = val;
    notifyListeners();
  }

  void toggleFetchingLocations(bool val) {
    _fetchingLocations = val;
    notifyListeners();
  }

  void toggleFetchingTopRated(bool val) {
    _fetchingTopRated = val;
    notifyListeners();
  }

  Future<void> topRatedMechanicsResults() async {
    try {
      if (_fetchingTopRated) return;
      toggleFetchingTopRated(true);
      await _homeDomain.getTopRatedMechanics(
          const LatLng(6.868767670611358, 7.395066872028245));
      print(topRated);
      toggleFetchingTopRated(false);
    } catch (e) {
      toggleFetchingTopRated(false);
    }
  }

  Future<void> getNearbySearchResultsWithPLaceId(
      String placeId, String sessiontoken) async {
    toggleFetchingMechanocs(true);
    try {
      var res = await googleMapServices.getPlaceDetails(placeId, sessiontoken);
      print("latitude: ${res.placeModel!.latitude!}");
      await nearbySearchResults(
          res.placeModel!.latitude!, res.placeModel!.longitude!);
    } catch (e) {
      toggleFetchingMechanocs(false);
    }
    toggleFetchingMechanocs(false);
  }

  Future<void> nearbySearchResults(double latitude, double longitude) async {
    try {
      toggleFetchingMechanocs(true);
      await _homeDomain.getNearbyMechanics(LatLng(latitude, longitude));
      print("mechanics: $mechanics");
      toggleFetchingMechanocs(false);
    } catch (e) {
      toggleFetchingMechanocs(false);
    }
  }

  Future<void> locationsSearchResults(String query, String sessiontoken) async {
    try {
      toggleFetchingLocations(true);
      await _homeDomain.locationSearchResults(query, sessiontoken);
      print("locations: $locations");
      toggleFetchingLocations(false);
    } catch (e) {
      toggleFetchingLocations(false);
    }
  }

  LatLng latLngFromSharedPrefs() {
    return localCache.getCurrentLatLngFromSharedPrefs();
  }

  String currentAddressFromSharedPrefs() {
    return localCache.getCurrentAddressFromSharedPrefs();
  }
}
