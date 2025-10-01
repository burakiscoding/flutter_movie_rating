import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/movie_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'add_rating_state.dart';

class AddRatingCubit extends Cubit<AddRatingState>
    with BlocMixin<AddRatingState> {
  AddRatingCubit({
    required MovieRepository movieRepository,
    required this.movieId,
  }) : _movieRepository = movieRepository,
       super(const AddRatingState());

  final MovieRepository _movieRepository;
  final int movieId;

  Future<void> addRating(double rating, String comment) async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _movieRepository.addRating(movieId, rating, comment);
    result.fold(
      (f) {
        emitSafe(state.copyWith(isLoading: false, failure: f));
      },
      (data) {
        emitSafe(state.copyWith(isLoading: false, succes: data));
      },
    );
  }
}
