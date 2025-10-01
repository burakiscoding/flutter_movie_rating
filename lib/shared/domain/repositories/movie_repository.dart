import 'package:flutter_movie_rating/shared/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getAll();
  Future<Either<Failure, MovieDetailEntity>> getById(int id);
  Future<Either<Failure, List<MovieRatingEntity>>> getRatings(int id);
  Future<Either<Failure, SuccessEntity>> addRating(int movieId, double rating, String comment);
}
