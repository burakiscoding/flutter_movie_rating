part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileGetStarted extends ProfileEvent {}

final class ProfileUpdatePressed extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String aboutMe;

  const ProfileUpdatePressed({
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
  });

  @override
  List<Object> get props => [firstName, lastName, aboutMe];
}

final class ProfileGetRatingsPressed extends ProfileEvent {}

final class ProfileRatingViewClosed extends ProfileEvent {}
