import 'package:flutter_movie_rating/shared/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_media_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final int id;
  final String name;
  final String description;
  final int rating;
  final DateTime releaseDate;
  final int durationInMinutes;
  final List<GenreModel> genres;
  final List<ActorModel> actors;
  final List<MediaModel> medias;

  const MovieDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.releaseDate,
    required this.durationInMinutes,
    required this.genres,
    required this.actors,
    required this.medias,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => _$MovieDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);
}

@JsonSerializable()
class ActorModel {
  final int id;
  final String lastName;
  final String firstName;

  const ActorModel({required this.id, required this.lastName, required this.firstName});

  factory ActorModel.fromJson(Map<String, dynamic> json) => _$ActorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActorModelToJson(this);
}

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  const GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class MediaModel {
  final String name;
  final int type;

  const MediaModel({required this.name, required this.type});

  factory MediaModel.fromJson(Map<String, dynamic> json) => _$MediaModelFromJson(json);
  Map<String, dynamic> toJson() => _$MediaModelToJson(this);

  MovieMediaType get mediaType {
    switch (type) {
      case 0:
        return MovieMediaType.image;
      case 1:
        return MovieMediaType.video;
      case 2:
        return MovieMediaType.poster;
      case 3:
        return MovieMediaType.trailer;
      default:
        return MovieMediaType.unknown;
    }
  }
}

extension MovieDetailX on MovieDetailModel {
  MovieDetailEntity toEntity() {
    return MovieDetailEntity(
      id: id,
      name: name,
      description: description,
      rating: rating,
      releaseDate: releaseDate,
      durationInMinutes: durationInMinutes,
      genres: genres.map((e) => GenreEntity(id: e.id, name: e.name)).toList(),
      actors: actors.map((e) => ActorEntity(id: e.id, lastName: e.lastName, firstName: e.firstName)).toList(),
      medias: medias.map((e) => MediaEntity(name: e.name, type: e.mediaType)).toList(),
    );
  }
}
