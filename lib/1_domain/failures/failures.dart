abstract class Failure {
  final String error;

  Failure({required this.error});
}

class ServerFailure extends Failure {
  ServerFailure({required super.error});
}

class GeneralFailure extends Failure {
  GeneralFailure({required super.error});
}
