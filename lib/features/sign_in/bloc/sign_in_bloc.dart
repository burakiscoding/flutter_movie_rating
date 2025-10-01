import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie_rating/shared/domain/entities/auth_success_entity.dart';
import 'package:flutter_movie_rating/shared/domain/repositories/user_repository.dart';
import 'package:flutter_movie_rating/shared/models/failure.dart';
import 'package:flutter_movie_rating/shared/presentation/bloc_mixin.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>
    with BlocMixin<SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const SignInState()) {
    on<SignInPressed>(_signIn);
  }

  Future<void> _signIn(SignInPressed event, Emitter<SignInState> emit) async {
    emitSafe(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _userRepository.signIn(event.email, event.password);
    result.fold(
      (f) {
        emitSafe(state.copyWith(failure: f, isLoading: false));
      },
      (data) {
        emitSafe(state.copyWith(authSuccess: data, isLoading: false));
      },
    );
  }
}
