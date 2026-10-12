class Failure {
  final String message;

  Failure({required this.message});
  @override
  String toString() {
    return message;
  }
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}
