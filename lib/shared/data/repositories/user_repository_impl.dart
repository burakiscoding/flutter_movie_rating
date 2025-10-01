import 'package:flutter_movie_rating/shared/data/datasources/user_local_secure_data_source.dart';
import 'package:flutter_movie_rating/shared/data/datasources/user_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/data/models/auth_success_model.dart';
import 'package:flutter_movie_rating/shared/data/models/profile_model.dart';
import 'package:flutter_movie_rating/shared/data/models/user_movie_rating_model.dart';
import 'package:flutter_movie_rating/shared/domain/entities/auth_success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/profile_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/user_movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/network/success_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalSecureDataSource _userLocalSecureDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource userRemoteDataSource,
    required UserLocalSecureDataSource userLocalSecureDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource,
       _userLocalSecureDataSource = userLocalSecureDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    final result = await _userRemoteDataSource.getProfile();
    return result.fold((f) => Left(f), (data) => Right(data.toEntity()));
  }

  @override
  Future<Either<Failure, List<UserMovieRatingEntity>>> getRatings() async {
    final result = await _userRemoteDataSource.getRatings();
    return result.fold(
      (f) => Left(f),
      (data) => Right(data.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, AuthSuccessEntity>> signIn(
    String email,
    String password,
  ) async {
    final result = await _userRemoteDataSource.signIn(email, password);
    return result.fold(
      (f) async {
        await _userLocalSecureDataSource.clearTokens();
        return Left(f);
      },
      (data) async {
        await _userLocalSecureDataSource.saveToken(data.token);
        return Right(data.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, AuthSuccessEntity>> signUp(
    String email,
    String password,
  ) async {
    final result = await _userRemoteDataSource.signIn(email, password);
    return result.fold(
      (f) async {
        await _userLocalSecureDataSource.clearTokens();
        return Left(f);
      },
      (data) async {
        await _userLocalSecureDataSource.saveToken(data.token);
        return Right(data.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, SuccessEntity>> updateProfile(
    String firstName,
    String lastName,
    String aboutMe,
  ) async {
    final result = await _userRemoteDataSource.updateProfile(
      firstName,
      lastName,
      aboutMe,
    );
    return result.fold((f) => Left(f), (data) => Right(data.toEntity()));
  }
}
