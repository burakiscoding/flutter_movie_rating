import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/movie_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> with BlocMixin<MoviesState> {
  final MovieRepository _movieRepository;

  MoviesBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(const MoviesState.initial()) {
    on<MoviesGetAllStarted>(_getAll);
  }

  Future<void> _getAll(MoviesGetAllStarted event, Emitter<MoviesState> emit) async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _movieRepository.getAll();
    result.fold(
      (f) {
        emitSafe(state.copyWith(failure: f, isLoading: false));
      },
      (data) {
        emitSafe(state.copyWith(movies: data, isLoading: false));
      },
    );
  }
}
