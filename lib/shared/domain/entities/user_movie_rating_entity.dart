class UserMovieRatingEntity {
  final int id;
  final int movieId;
  final String movieName;
  final double rating;
  final String comment;

  const UserMovieRatingEntity({
    required this.id,
    required this.movieId,
    required this.movieName,
    required this.rating,
    required this.comment,
  });
}
