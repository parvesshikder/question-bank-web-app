abstract class Failure {
  
}

class ServerFailure extends Failure {
  final String error;

  ServerFailure({required this.error});
}

class GeneralFailure extends Failure {
  
}
