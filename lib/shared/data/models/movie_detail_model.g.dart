// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) =>
    MovieDetailModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toInt(),
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      durationInMinutes: (json['durationInMinutes'] as num).toInt(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      actors: (json['actors'] as List<dynamic>)
          .map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      medias: (json['medias'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'durationInMinutes': instance.durationInMinutes,
      'genres': instance.genres,
      'actors': instance.actors,
      'medias': instance.medias,
    };

ActorModel _$ActorModelFromJson(Map<String, dynamic> json) => ActorModel(
  id: (json['id'] as num).toInt(),
  lastName: json['lastName'] as String,
  firstName: json['firstName'] as String,
);

Map<String, dynamic> _$ActorModelToJson(ActorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
    };

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) =>
    GenreModel(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
  name: json['name'] as String,
  type: (json['type'] as num).toInt(),
);

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.type};
