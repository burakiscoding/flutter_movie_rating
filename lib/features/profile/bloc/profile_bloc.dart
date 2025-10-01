import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/profile_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/entities/user_movie_rating_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with BlocMixin<ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const ProfileState()) {
    on<ProfileUpdatePressed>(_update);
    on<ProfileGetStarted>(_getProfile);
    on<ProfileGetRatingsPressed>(_getRatings);
    on<ProfileRatingViewClosed>(_closeRatingView);
  }

  Future<void> _update(
    ProfileUpdatePressed event,
    Emitter<ProfileState> emit,
  ) async {
    emitSafe(state.copyWith(isUpdating: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userRepository.updateProfile(
      event.firstName,
      event.lastName,
      event.aboutMe,
    );
    result.fold(
      (f) {
        emitSafe(state.copyWith(isUpdating: false, updateFailure: f));
      },
      (data) {
        final profile = ProfileEntity(
          firstName: event.firstName,
          lastName: event.lastName,
          aboutMe: event.aboutMe,
        );
        emitSafe(
          state.copyWith(
            isUpdating: false,
            updateSuccess: data,
            profile: profile,
          ),
        );
      },
    );
  }

  Future<void> _getProfile(
    ProfileGetStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userRepository.getProfile();
    result.fold(
      (f) {
        emitSafe(state.copyWith(isLoading: false, getFailure: f));
      },
      (data) {
        emitSafe(state.copyWith(isLoading: false, profile: data));
      },
    );
  }

  Future<void> _getRatings(
    ProfileGetRatingsPressed event,
    Emitter<ProfileState> emit,
  ) async {
    emitSafe(state.copyWith(isRatingsLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userRepository.getRatings();
    result.fold(
      (f) {
        emitSafe(state.copyWith(isRatingsLoading: false, ratingFailure: f));
      },
      (data) {
        emitSafe(
          state.copyWith(
            isRatingsLoading: false,
            ratings: data,
            showRatingView: true,
          ),
        );
      },
    );
  }

  void _closeRatingView(
    ProfileRatingViewClosed event,
    Emitter<ProfileState> emit,
  ) {
    emitSafe(state.copyWith(showRatingView: false));
  }
}
