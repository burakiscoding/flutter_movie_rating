part of 'add_rating_cubit.dart';

final class AddRatingState extends Equatable {
  const AddRatingState({this.succes, this.isLoading = false, this.failure});

  final SuccessEntity? succes;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [succes, isLoading, failure];

  AddRatingState copyWith({
    SuccessEntity? succes,
    bool? isLoading,
    Failure? failure,
  }) {
    return AddRatingState(
      succes: succes,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
