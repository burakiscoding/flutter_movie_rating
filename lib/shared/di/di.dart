import 'package:dio/dio.dart';
import 'package:flutter_movie_rating/shared/data/datasources/movie_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_local_secure_data_source.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movie_rating/shared/data/repositories/user_repository_impl.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/network/network_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupDI() {
  getIt.registerFactory<FlutterSecureStorage>(FlutterSecureStorage.new);
  getIt.registerFactory<UserLocalSecureDataSource>(
    () => UserLocalSecureDataSourceImpl(flutterSecureStorage: getIt<FlutterSecureStorage>()),
  );
  getIt.registerFactory<Dio>(() {
    return Dio(BaseOptions(baseUrl: "http://localhost:8080", headers: {"Content-Type": "application/json"}))
      ..interceptors.add(TokenInterceptor(userLocalSecureDataSource: getIt<UserLocalSecureDataSource>()));
  });
  getIt.registerFactory<NetworkService>(() => NetworkServiceImpl(dio: getIt<Dio>()));
  getIt.registerFactory<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(networkService: getIt<NetworkService>()),
  );
  getIt.registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(networkService: getIt<NetworkService>()));
  getIt.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(movieRemoteDataSource: getIt<MovieRemoteDataSource>()),
  );
  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      userRemoteDataSource: getIt<UserRemoteDataSource>(),
      userLocalSecureDataSource: getIt<UserLocalSecureDataSource>(),
    ),
  );
}
