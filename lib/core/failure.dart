abstract class Failure {
  @override
  String toString() {
    return 'An error occured';
  }
}

class ExpiredSessionFailure extends Failure {
  @override
  String toString() {
    return 'Session has expired. Please log in again!';
  }
}

class AuthFailure extends Failure {
  final String errorMessage;
  AuthFailure(this.errorMessage);
  @override
  String toString() {
    return errorMessage;
  }
}
