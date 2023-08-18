import 'package:dartz/dartz.dart';
import 'package:questionbankleggasi/1_domain/entities/legasi_home_entities.dart';
import 'package:questionbankleggasi/1_domain/failures/failures.dart';

abstract class QuestionTakerRepo {
  Future<Either<Failure, LegasiHomeLoggedUserEntities>>
      getQuestionsDataFromFirebase(
          String email, String password);

}
