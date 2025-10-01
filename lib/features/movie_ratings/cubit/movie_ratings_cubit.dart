import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'movie_ratings_state.dart';

class MovieRatingsCubit extends Cubit<MovieRatingsState>
    with BlocMixin<MovieRatingsState> {
  MovieRatingsCubit({
    required MovieRepository movieRepository,
    required this.id,
  }) : _movieRepository = movieRepository,
       super(const MovieRatingsState()) {
    _getRatings();
  }

  final MovieRepository _movieRepository;
  final int id;

  Future<void> _getRatings() async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _movieRepository.getRatings(id);
    result.fold(
      (f) {
        emitSafe(state.copyWith(isLoading: false, failure: f));
      },
      (data) {
        emitSafe(state.copyWith(isLoading: false, ratings: data));
      },
    );
  }
}
