// core/failures.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class SymbolNotFoundFailure extends Failure {
  SymbolNotFoundFailure(super.message);
}
