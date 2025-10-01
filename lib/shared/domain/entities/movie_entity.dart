import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String name;
  final String poster;
  final double rating;
  final DateTime releaseDate;
  final int durationInMinutes;

  const MovieEntity({
    required this.id,
    required this.name,
    required this.poster,
    required this.rating,
    required this.releaseDate,
    required this.durationInMinutes,
  });

  String get durationString {
    final h = durationInMinutes ~/ 60;
    final m = durationInMinutes % 60;
    return '${h}h ${m}m';
  }

  String get ratingString {
    return rating.toStringAsFixed(1);
  }

  @override
  List<Object?> get props => [id, name, poster, rating, releaseDate, durationInMinutes];
}
