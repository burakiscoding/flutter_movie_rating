import 'package:bloc/bloc.dart';

mixin BlocMixin<State> on BlocBase<State> {
  void emitSafe(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
