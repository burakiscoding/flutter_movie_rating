// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieRatingModel _$MovieRatingModelFromJson(Map<String, dynamic> json) =>
    MovieRatingModel(
      id: (json['id'] as num).toInt(),
      movieId: (json['movieId'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$MovieRatingModelToJson(MovieRatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'rating': instance.rating,
      'comment': instance.comment,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
