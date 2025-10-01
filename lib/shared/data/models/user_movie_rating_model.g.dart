// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_movie_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMovieRatingModel _$UserMovieRatingModelFromJson(
  Map<String, dynamic> json,
) => UserMovieRatingModel(
  id: (json['id'] as num).toInt(),
  movieId: (json['movieId'] as num).toInt(),
  movieName: json['movieName'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String,
);

Map<String, dynamic> _$UserMovieRatingModelToJson(
  UserMovieRatingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'movieId': instance.movieId,
  'movieName': instance.movieName,
  'rating': instance.rating,
  'comment': instance.comment,
};
