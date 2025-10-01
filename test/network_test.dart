import 'package:dio/dio.dart';
import 'package:flutter_movie_rating/shared/data/datasources/movie_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_local_secure_data_source.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/network/network_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final UserLocalSecureDataSource userLocalSecureDataSource =
      UserLocalSecureDataSourceImpl(
        flutterSecureStorage: const FlutterSecureStorage(),
      );
  late final dio =
      Dio(
          BaseOptions(
            baseUrl: "http://localhost:8080",
            headers: {"Content-Type": "application/json"},
          ),
        )
        ..interceptors.add(
          TokenInterceptor(
            userLocalSecureDataSource: userLocalSecureDataSource,
          ),
        );
  late final NetworkService networkService = NetworkServiceImpl(dio: dio);
  late final MovieRemoteDataSource movieRemoteDataSource =
      MovieRemoteDataSourceImpl(networkService: networkService);
  late final UserRemoteDataSource userRemoteDataSource =
      UserRemoteDataSourceImpl(networkService: networkService);

  group('movie datasource test group', () {
    test('get all movies', () async {
      final result = await movieRemoteDataSource.getAll();
      final movies = result.fold((failure) => null, (data) => data);
      expect(movies, isNotNull);
    });

    test('get movie by id', () async {
      final result = await movieRemoteDataSource.getById(1);
      final movie = result.fold((failure) => null, (data) => data);
      expect(movie, isNotNull);
    });

    test('get movie ratings', () async {
      final result = await movieRemoteDataSource.getRatings(1);
      final ratings = result.fold((failure) => null, (data) => data);
      expect(ratings, isNotNull);
    });

    test('add rating', () async {
      final result = await movieRemoteDataSource.addRating(
        1,
        9.5,
        'Very impressive and amazing movie.',
      );
      final success = result.fold((failure) => null, (data) => data);
      expect(success, isNotNull);
    });
  });

  group('user datasource test group', () {
    test('sign up', () async {
      final result = await userRemoteDataSource.signUp(
        'testuser2@gmail.com',
        'testuser2',
      );
      final authSuccessModel = result.fold((failure) => null, (data) => data);
      expect(authSuccessModel, isNotNull);
    });

    test('sign in', () async {
      final result = await userRemoteDataSource.signIn(
        'testuser1@gmail.com',
        'testuser1',
      );
      final authSuccessModel = result.fold((failure) => null, (data) => data);
      // print(authSuccessModel?.token);
      expect(authSuccessModel, isNotNull);
    });

    test('get profile', () async {
      final result = await userRemoteDataSource.getProfile();
      final profileModel = result.fold((failure) => null, (data) => data);
      expect(profileModel, isNotNull);
    });

    test('update profile', () async {
      final result = await userRemoteDataSource.updateProfile(
        "Monte",
        "Cristo",
        "Im a very rich count",
      );
      final successModel = result.fold((failure) => null, (data) => data);
      expect(successModel, isNotNull);
    });

    test('get user ratings', () async {
      final result = await userRemoteDataSource.getRatings();
      final ratings = result.fold((failure) => null, (data) => data);
      expect(ratings, isNotNull);
    });
  });
}
