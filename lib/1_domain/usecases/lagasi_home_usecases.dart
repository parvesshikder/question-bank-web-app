import 'package:dartz/dartz.dart';
import 'package:questionbankleggasi/0_data/repository/legasi_home_repo_impl.dart';
import 'package:questionbankleggasi/1_domain/entities/legasi_home_entities.dart';
import 'package:questionbankleggasi/1_domain/failures/failures.dart';
import 'package:questionbankleggasi/1_domain/repository/lagasi_home_repo.dart';

class LegasiHomeUseCases {
  LegasiHomeRepo legasiHomeRepo = LegasiHomeRepoImpls();

  Future<Either<Failure, LegasiHomeLoggedUserEntities>> logIn(
      email, password) async {
    return legasiHomeRepo.firebaseLoginAndGetUserDetails(email, password);
  }
}
