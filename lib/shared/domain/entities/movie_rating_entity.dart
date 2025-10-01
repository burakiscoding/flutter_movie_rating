class MovieRatingEntity {
  final int id;
  final int movieId;
  final int rating;
  final String comment;
  final String firstName;
  final String lastName;

  const MovieRatingEntity({
    required this.id,
    required this.movieId,
    required this.rating,
    required this.comment,
    required this.firstName,
    required this.lastName,
  });

  String get fullNameOfPerson => '$firstName $lastName';
}
