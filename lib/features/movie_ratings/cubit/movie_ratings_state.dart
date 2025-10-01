part of 'movie_ratings_cubit.dart';

final class MovieRatingsState extends Equatable {
  const MovieRatingsState({
    this.ratings = const [],
    this.isLoading = false,
    this.failure,
  });

  final List<MovieRatingEntity> ratings;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [ratings, isLoading, failure];

  MovieRatingsState copyWith({
    List<MovieRatingEntity>? ratings,
    bool? isLoading,
    Failure? failure,
  }) {
    return MovieRatingsState(
      ratings: ratings ?? this.ratings,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
