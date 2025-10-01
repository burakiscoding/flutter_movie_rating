import 'package:flutter_movie_rating/shared/data/models/auth_success_model.dart';
import 'package:flutter_movie_rating/shared/data/models/profile_model.dart';
import 'package:flutter_movie_rating/shared/data/models/user_movie_rating_model.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/network/http_method.dart';
import 'package:flutter_movie_rating/shared/network/network_service.dart';
import 'package:flutter_movie_rating/shared/network/success_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, AuthSuccessModel>> signUp(
    String email,
    String password,
  );
  Future<Either<Failure, AuthSuccessModel>> signIn(
    String email,
    String password,
  );
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, SuccessModel>> updateProfile(
    String firstName,
    String lastName,
    String aboutMe,
  );
  Future<Either<Failure, List<UserMovieRatingModel>>> getRatings();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final NetworkService _networkService;

  UserRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Either<Failure, AuthSuccessModel>> signIn(
    String email,
    String password,
  ) {
    return _networkService.request<AuthSuccessModel, AuthSuccessModel>(
      '/user/signIn',
      method: HttpMethod.post,
      data: {'email': email, 'password': password},
      decode: AuthSuccessModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, AuthSuccessModel>> signUp(
    String email,
    String password,
  ) {
    return _networkService.request(
      '/user/signUp',
      method: HttpMethod.post,
      data: {'email': email, 'password': password},
      decode: AuthSuccessModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() {
    return _networkService.request<ProfileModel, ProfileModel>(
      '/user/profile',
      decode: ProfileModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, SuccessModel>> updateProfile(
    String firstName,
    String lastName,
    String aboutMe,
  ) {
    return _networkService.request<SuccessModel, SuccessModel>(
      '/user/profile',
      method: HttpMethod.put,
      data: {'firstName': firstName, 'lastName': lastName, 'aboutMe': aboutMe},
      decode: SuccessModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, List<UserMovieRatingModel>>> getRatings() {
    return _networkService
        .request<List<UserMovieRatingModel>, UserMovieRatingModel>(
          '/user/ratings',
          decode: UserMovieRatingModel.fromJson,
        );
  }
}
