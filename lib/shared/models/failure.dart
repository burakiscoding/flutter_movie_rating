abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  String toString() {
    return 'Failure(code: $code, message: $message)';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message, super.code})
    : super(message: message ?? 'Network problem happened');

  @override
  String toString() {
    return 'NetworkFailure(code: $code, message: $message)';
  }
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({String? message, super.code})
    : super(message: message ?? 'Unauthorized user. Please sign in.');

  @override
  String toString() {
    return 'AuthenticationFailure(code: $code, message: $message)';
  }
}
