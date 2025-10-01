import 'package:flutter_movie_rating/shared/domain/entities/auth_success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/profile_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/user_movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthSuccessEntity>> signUp(
    String email,
    String password,
  );
  Future<Either<Failure, AuthSuccessEntity>> signIn(
    String email,
    String password,
  );
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, SuccessEntity>> updateProfile(
    String firstName,
    String lastName,
    String aboutMe,
  );
  Future<Either<Failure, List<UserMovieRatingEntity>>> getRatings();
}
