import 'package:flutter_movie_rating/shared/domain/entities/movie_media_type.dart';

class MovieDetailEntity {
  final int id;
  final String name;
  final String description;
  final int rating;
  final DateTime releaseDate;
  final int durationInMinutes;
  final List<GenreEntity> genres;
  final List<ActorEntity> actors;
  final List<MediaEntity> medias;

  const MovieDetailEntity({
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

  String get durationString {
    final h = durationInMinutes ~/ 60;
    final m = durationInMinutes % 60;
    return '${h}h ${m}m';
  }

  String get ratingString {
    return rating.toStringAsFixed(1);
  }

  List<String> get images {
    return medias
        .where((e) => e.type == MovieMediaType.image || e.type == MovieMediaType.poster)
        .map((e) => e.name)
        .toList();
  }

  List<String> get videos {
    return medias
        .where((e) => e.type == MovieMediaType.video || e.type == MovieMediaType.trailer)
        .map((e) => e.name)
        .toList();
  }

  String get poster {
    final images = medias.where((e) => e.type == MovieMediaType.poster).toList();
    if (images.isEmpty) {
      return "http://localhost:8080/movies/1/media/madame-web-1.jpg";
    }
    return images[0].name;
  }

  String? get trailer {
    final videos = medias.where((e) => e.type == MovieMediaType.trailer).toList();
    if (videos.isEmpty) {
      return null;
    }
    return videos[0].name;
  }
}

class GenreEntity {
  final int id;
  final String name;

  const GenreEntity({required this.id, required this.name});
}

class ActorEntity {
  final int id;
  final String lastName;
  final String firstName;

  String get fullName => '$firstName $lastName';

  const ActorEntity({required this.id, required this.lastName, required this.firstName});
}

class MediaEntity {
  final String name;
  final MovieMediaType type;

  const MediaEntity({required this.name, required this.type});
}
