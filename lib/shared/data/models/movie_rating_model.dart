import 'package:flutter_movie_rating/shared/domain/entities/movie_rating_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_rating_model.g.dart';

@JsonSerializable()
class MovieRatingModel {
  final int id;
  final int movieId;
  final int rating;
  final String comment;
  final String firstName;
  final String lastName;

  const MovieRatingModel({
    required this.id,
    required this.movieId,
    required this.rating,
    required this.comment,
    required this.firstName,
    required this.lastName,
  });

  factory MovieRatingModel.fromJson(Map<String, dynamic> json) => _$MovieRatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieRatingModelToJson(this);
}

extension MovieRatingX on MovieRatingModel {
  MovieRatingEntity toEntity() {
    return MovieRatingEntity(
      id: id,
      movieId: movieId,
      rating: rating,
      comment: comment,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
