import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:mobi_mech/data/local/local_cache.dart';
// import 'package:mobi_mech/data/remote/connectivity_service.dart';
import 'package:mobi_mech/models/api/api_error_response.dart';
import 'package:mobi_mech/models/api/api_response.dart';
// import 'package:mobi_mech/utils/locator.dart';
import 'package:mobi_mech/utils/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dartz/dartz.dart';

abstract class BaseApi {
  late Dio dio;
  BaseApi(String baseApi) {
    final options = BaseOptions(
      baseUrl: "https://$baseApi",
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds)
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      options,
      handler,
    ) async {
      //no internet? reject request
      // if (!await locator<ConnectivityService>().hasInternet()) {
      //   handler.reject(
      //     DioError(
      //       requestOptions: options,
      //       error:
      //           "Oops! Looks like you're not connected to the internet. Check your internet connection and try again.",
      //     ),
      //   );
      // }

      // var token = await locator<LocalCache>().getToken();
      // AppLogger.log(token);
      // if (token != null) {
      //   options.headers['X-ACCESS-TOKEN'] = token;
      // }
      handler.next(options);
    }));
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  Future<Either<Failure, Success>> get(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) {
    print("Path: $path");
    return makeRequest(
      dio.request(
        "/$path",
        data: data,
        options: Options(
          method: "GET",
          headers: {
            ...headers, // set content-length
          },
        ),
      ),
    );
  }

  Future<Either<Failure, Success>> post(path,
      {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) {
    return makeRequest(dio.post(
      "/$path",
      data: data,
      options: Options(
        headers: {
          ...headers, // set content-length
        },
      ),
    ));
  }

  Future<Either<Failure, Success>> patch(path,
      {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) {
    return makeRequest(dio.patch(
      "/$path",
      data: data,
      options: Options(
        headers: {
          ...headers, // set content-length
        },
      ),
    ));
  }

  Future<Either<Failure, Success>> put(path,
          {Map<String, dynamic>? data,
          Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.put(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Either<Failure, Success>> delete(path,
          {Map<String, dynamic>? data,
          Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.delete(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Either<Failure, Success>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;

      AppLogger.log(
          'this is the status code for every request made=> ${req.statusCode}');

      //check for status code that indicates expired session and log user out
      log('Status Code: ${req.statusCode.toString()}');
      if ("${req.statusCode}".startsWith('2')) {
        if (data is! Map) {
          return Right(Success(<String, dynamic>{"data": data}));
        }
        return Right(Success(data as Map<String, dynamic>));
      }

      return Left(Failure(data["message"]));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Left(
          Failure(
            const ApiErrorResponse(
              message:
                  "Oops. It took too long to send your request. Check your internet connection and try again.",
            ),
          ),
        );
      }
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null && e.response!.data is Map) {
          return Left(Failure.fromMap(e.response!.data));
        }
        return Left(Failure(e.response?.data));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Left(Failure(
          ApiErrorResponse(message: e.message),
        ));
      }
    }
  }

  dynamic parseErrorMessage(Map<String, dynamic>? err) {
    if (err != null) {}
    return "Unknown error";
  }
}
