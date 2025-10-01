import 'package:flutter_movie_rating/shared/data/models/movie_detail_model.dart';
import 'package:flutter_movie_rating/shared/data/models/movie_model.dart';
import 'package:flutter_movie_rating/shared/data/models/movie_rating_model.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/network/http_method.dart';
import 'package:flutter_movie_rating/shared/network/network_service.dart';
import 'package:flutter_movie_rating/shared/models/either.dart';
import 'package:flutter_movie_rating/shared/network/success_model.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, List<MovieModel>>> getAll();
  Future<Either<Failure, MovieDetailModel>> getById(int id);
  Future<Either<Failure, List<MovieRatingModel>>> getRatings(int id);
  Future<Either<Failure, SuccessModel>> addRating(int movieId, double rating, String comment);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final NetworkService _networkService;

  MovieRemoteDataSourceImpl({required NetworkService networkService}) : _networkService = networkService;

  @override
  Future<Either<Failure, List<MovieModel>>> getAll() {
    return _networkService.request<List<MovieModel>, MovieModel>('/movies', decode: MovieModel.fromJson);
  }

  @override
  Future<Either<Failure, MovieDetailModel>> getById(int id) {
    return _networkService.request<MovieDetailModel, MovieDetailModel>(
      '/movies/$id',
      decode: MovieDetailModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, SuccessModel>> addRating(int movieId, double rating, String comment) {
    return _networkService.request<SuccessModel, SuccessModel>(
      '/movies/$movieId/ratings',
      method: HttpMethod.post,
      data: {'rating': rating, 'comment': comment},
      decode: SuccessModel.fromJson,
    );
  }

  @override
  Future<Either<Failure, List<MovieRatingModel>>> getRatings(int id) {
    return _networkService.request('/movies/$id/ratings', decode: MovieRatingModel.fromJson);
  }
}
