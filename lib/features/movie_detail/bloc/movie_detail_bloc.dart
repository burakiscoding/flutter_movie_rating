import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_detail_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> with BlocMixin<MovieDetailState> {
  final MovieRepository _movieRepository;
  final int _id;

  MovieDetailBloc({required MovieRepository movieRepository, required int id})
    : _movieRepository = movieRepository,
      _id = id,
      super(const MovieDetailState(isLoading: false)) {
    on<MovieDetailGetStarted>(_getById);
  }

  Future<void> _getById(MovieDetailGetStarted event, Emitter<MovieDetailState> emit) async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _movieRepository.getById(_id);
    result.fold(
      (f) {
        emitSafe(state.copyWith(failure: f, isLoading: false));
      },
      (data) {
        emitSafe(state.copyWith(movieDetail: data, isLoading: false));
      },
    );
  }
}
