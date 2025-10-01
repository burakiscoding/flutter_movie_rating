// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  poster: json['poster'] as String,
  rating: (json['rating'] as num).toDouble(),
  releaseDate: DateTime.parse(json['releaseDate'] as String),
  durationInMinutes: (json['durationInMinutes'] as num).toInt(),
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'poster': instance.poster,
      'rating': instance.rating,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'durationInMinutes': instance.durationInMinutes,
    };
