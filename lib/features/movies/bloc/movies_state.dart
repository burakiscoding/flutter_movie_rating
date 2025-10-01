part of 'movies_bloc.dart';

final class MoviesState extends Equatable {
  const MoviesState({required this.movies, required this.isLoading, this.failure});

  final List<MovieEntity> movies;
  final bool isLoading;
  final Failure? failure;

  const MoviesState.initial({this.movies = const <MovieEntity>[], this.isLoading = false, this.failure});

  @override
  List<Object?> get props => [movies, isLoading, failure];

  MoviesState copyWith({List<MovieEntity>? movies, bool? isLoading, Failure? failure}) {
    return MoviesState(movies: movies ?? this.movies, isLoading: isLoading ?? this.isLoading, failure: failure);
  }
}
