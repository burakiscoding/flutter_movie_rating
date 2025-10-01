import 'package:flutter_movie_rating/shared/domain/entities/movie_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String name;
  final String poster;
  final double rating;
  final DateTime releaseDate;
  final int durationInMinutes;

  const MovieModel({
    required this.id,
    required this.name,
    required this.poster,
    required this.rating,
    required this.releaseDate,
    required this.durationInMinutes,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}

extension MovieModelX on MovieModel {
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      name: name,
      poster: poster,
      rating: rating,
      releaseDate: releaseDate,
      durationInMinutes: durationInMinutes,
    );
  }
}
