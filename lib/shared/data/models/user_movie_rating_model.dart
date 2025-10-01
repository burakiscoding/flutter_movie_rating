import 'package:flutter_movie_rating/shared/domain/entities/user_movie_rating_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_movie_rating_model.g.dart';

@JsonSerializable()
class UserMovieRatingModel {
  final int id;
  final int movieId;
  final String movieName;
  final double rating;
  final String comment;

  const UserMovieRatingModel({
    required this.id,
    required this.movieId,
    required this.movieName,
    required this.rating,
    required this.comment,
  });

  factory UserMovieRatingModel.fromJson(Map<String, dynamic> json) => _$UserMovieRatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserMovieRatingModelToJson(this);
}

extension UserMovideRatingModelX on UserMovieRatingModel {
  UserMovieRatingEntity toEntity() {
    return UserMovieRatingEntity(id: id, movieId: movieId, movieName: movieName, rating: rating, comment: comment);
  }
}
