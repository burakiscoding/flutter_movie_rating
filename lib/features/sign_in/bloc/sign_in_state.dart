part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({this.authSuccess, this.isLoading = false, this.failure});

  final AuthSuccessEntity? authSuccess;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [authSuccess, isLoading, failure];

  SignInState copyWith({
    AuthSuccessEntity? authSuccess,
    bool? isLoading,
    Failure? failure,
  }) {
    return SignInState(
      authSuccess: authSuccess ?? this.authSuccess,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}
