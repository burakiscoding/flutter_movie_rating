part of 'movie_detail_bloc.dart';

final class MovieDetailState extends Equatable {
  const MovieDetailState({this.movieDetail, required this.isLoading, this.failure});

  final MovieDetailEntity? movieDetail;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [movieDetail, isLoading, failure];

  MovieDetailState copyWith({MovieDetailEntity? movieDetail, bool? isLoading, Failure? failure}) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
