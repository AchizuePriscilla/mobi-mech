import 'package:mobi_mech/utils/parser_util.dart';

class PlaceModel {
  final String? formattedAddress;
  final String? name;
  final double? rating;
  final double? userRatingstotal;
  final String? photoUrl;
  final String? description;
  final double? longitude;
  final double? latitude;
  final String? placeId;
  final bool? openNow;

  const PlaceModel(
      {this.formattedAddress,
      this.name,
      this.rating,
      this.photoUrl,
      this.userRatingstotal,
      this.description,
      this.latitude,
      this.placeId,
      this.openNow,
      this.longitude});

  factory PlaceModel.fromJson(Map json) {
    Map<String, dynamic> innerJson = Map<String, dynamic>.from(json);

    return PlaceModel(
      formattedAddress:
          ParserUtil.parseJsonString(innerJson, "formatted_address"),
      name: ParserUtil.parseJsonString(innerJson, "name"),
      description: ParserUtil.parseJsonString(innerJson, "description"),
      openNow:
          ParserUtil.parseJsonBoolean(innerJson["opening_hours"], "open_now"),
      placeId: ParserUtil.parseJsonString(innerJson, "place_id"),
      rating: ParserUtil.parseJsonNum(innerJson, "rating"),
      userRatingstotal:
          ParserUtil.parseJsonNum(innerJson, "user_ratings_total"),
      latitude: innerJson["geometry"] == null
          ? 0
          : ParserUtil.parseJsonNum(innerJson["geometry"]["location"], "lat"),
      longitude: innerJson["geometry"] == null
          ? 0
          : ParserUtil.parseJsonNum(innerJson["geometry"]["location"], "lng"),
      photoUrl: innerJson["photos"] != null
          ? innerJson["photos"][0]["photo_reference"]
          : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formatted_address': formattedAddress,
      'name': name,
      'rating': rating,
    };
  }
}
