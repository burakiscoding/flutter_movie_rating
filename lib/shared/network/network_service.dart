import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_local_secure_data_source.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/network/http_method.dart';
import 'package:flutter_movie_rating/shared/network/success_model.dart';

abstract class NetworkService {
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  });
  Future<Response<T>> post<T>(String path, {dynamic data, Options? options});
  Future<Response<T>> put<T>(String path, {dynamic data, Options? options});

  /// T: Return type
  /// P: Parse model type
  /// Returns [SuccessModel] if there is no data in response body
  Future<Either<Failure, T>> request<T, P>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? query,
    dynamic data,
    P Function(Map<String, dynamic> json)? decode,
  });
}

class NetworkServiceImpl extends NetworkService {
  final Dio _dio;

  NetworkServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) {
    return _dio.get<T>(path, queryParameters: query, options: options);
  }

  @override
  Future<Response<T>> post<T>(String path, {dynamic data, Options? options}) {
    return _dio.post<T>(path, data: data, options: options);
  }

  @override
  Future<Response<T>> put<T>(String path, {data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  @override
  Future<Either<Failure, T>> request<T, P>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? query,
    dynamic data,
    P Function(Map<String, dynamic> json)? decode,
  }) async {
    try {
      // Send request
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: query,
        options: Options(method: method.name),
      );

      // Handle error
      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! >= 300) {
        return Left(
          _handleError(
            response.data,
            response.statusCode,
            response.statusMessage,
          ),
        );
      }

      // Handle data
      return Right(_handleData<T, P>(response.data, decode));
    } on DioException catch (e) {
      return Left(
        // NetworkFailure(message: e.message, code: e.response?.statusCode),
        _handleError(e.response?.data, e.response?.statusCode, e.message),
      );
    } on Exception catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  T _handleData<T, P>(
    dynamic data,
    P Function(Map<String, dynamic> json)? decode,
  ) {
    if (data == null) {
      return const SuccessModel(message: 'Request completed successfully') as T;
    }

    if (decode == null) {
      return data as T;
    }

    if (data is List<dynamic>) {
      return data.map((e) => decode(e as Map<String, dynamic>)).toList() as T;
    }

    if (data is Map<String, dynamic>) {
      return decode(data) as T;
    }

    return data as T;
  }

  Failure _handleError(dynamic data, int? code, String? message) {
    if (code == HttpStatus.unauthorized) {
      return const AuthenticationFailure();
    }

    if (data is Map<String, dynamic>) {
      return NetworkFailure(message: data["error"], code: code);
    }

    if (data is String) {
      return NetworkFailure(message: data, code: code);
    }

    return NetworkFailure(message: message, code: code);
  }
}

class TokenInterceptor extends Interceptor {
  final UserLocalSecureDataSource _userLocalSecureDataSource;

  TokenInterceptor({
    required UserLocalSecureDataSource userLocalSecureDataSource,
  }) : _userLocalSecureDataSource = userLocalSecureDataSource;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _userLocalSecureDataSource.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
