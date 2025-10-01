part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.updateFailure,
    this.updateSuccess,
    this.getFailure,
    this.isUpdating = false,
    this.ratings = const <UserMovieRatingEntity>[],
    this.isRatingsLoading = false,
    this.ratingFailure,
    this.showRatingView = false,
  });

  final ProfileEntity? profile;
  final bool isLoading;
  final Failure? updateFailure;

  final SuccessEntity? updateSuccess;
  final bool isUpdating;
  final Failure? getFailure;

  final List<UserMovieRatingEntity> ratings;
  final bool isRatingsLoading;
  final Failure? ratingFailure;
  final bool showRatingView;

  @override
  List<Object?> get props => [
    profile,
    isLoading,
    updateFailure,
    getFailure,
    isUpdating,
    ratings,
    isRatingsLoading,
    ratingFailure,
    showRatingView,
  ];

  ProfileState copyWith({
    ProfileEntity? profile,
    bool? isLoading,
    Failure? updateFailure,
    SuccessEntity? updateSuccess,
    Failure? getFailure,
    bool? isUpdating,
    List<UserMovieRatingEntity>? ratings,
    bool? isRatingsLoading,
    Failure? ratingFailure,
    bool? showRatingView,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      updateFailure: updateFailure,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      getFailure: getFailure,
      isUpdating: isUpdating ?? this.isUpdating,
      ratings: ratings ?? this.ratings,
      isRatingsLoading: isRatingsLoading ?? this.isRatingsLoading,
      ratingFailure: ratingFailure,
      showRatingView: showRatingView ?? this.showRatingView,
    );
  }
}
