// core/failures.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server Failure: Could not fetch prices.');
}
