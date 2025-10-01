import 'package:flutter_movie_rating/shared/data/datasources/movie_remote_data_source.dart';
import 'package:flutter_movie_rating/shared/data/models/movie_detail_model.dart';
import 'package:flutter_movie_rating/shared/data/models/movie_model.dart';
import 'package:flutter_movie_rating/shared/data/models/movie_rating_model.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/network/success_model.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl({required MovieRemoteDataSource movieRemoteDataSource})
    : _movieRemoteDataSource = movieRemoteDataSource;

  @override
  Future<Either<Failure, SuccessEntity>> addRating(int movieId, double rating, String comment) async {
    final result = await _movieRemoteDataSource.addRating(movieId, rating, comment);
    return result.fold((f) => Left(f), (data) => Right(data.toEntity()));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getAll() async {
    final result = await _movieRemoteDataSource.getAll();
    return result.fold((f) => Left(f), (data) => Right(data.map((e) => e.toEntity()).toList()));
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getById(int id) async {
    final result = await _movieRemoteDataSource.getById(id);
    return result.fold((f) => Left(f), (data) => Right(data.toEntity()));
  }

  @override
  Future<Either<Failure, List<MovieRatingEntity>>> getRatings(int id) async {
    final result = await _movieRemoteDataSource.getRatings(id);
    return result.fold((f) => Left(f), (data) => Right(data.map((e) => e.toEntity()).toList()));
  }
}
