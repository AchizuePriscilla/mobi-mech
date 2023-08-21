import 'package:dartz/dartz.dart';
import 'package:mobi_mech/models/api/api_error_response.dart';
import 'package:mobi_mech/models/api/api_response.dart';
import 'package:mobi_mech/models/place_model.dart';

class PlacesResponse {
  final String? token;
  final bool success;
  final PlaceModel? placeModel;
  final ApiErrorResponse? error;

  const PlacesResponse({
    this.token,
    this.success = false,
    this.error,
    this.placeModel,
  });

  factory PlacesResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => PlacesResponse(error: failure.error),
      (success) => PlacesResponse(
        success: true,
        token: success.data["token"] ?? "",
        placeModel: PlaceModel.fromJson(success.data['results'][0])
      ),
    );
  }

}
