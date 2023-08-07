import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:questionbankleggasi/0_data/datasources/legasi_home_datasource.dart';
import 'package:questionbankleggasi/1_domain/entities/legasi_home_entities.dart';
import 'package:questionbankleggasi/1_domain/failures/failures.dart';
import 'package:questionbankleggasi/1_domain/repository/lagasi_home_repo.dart';

class LegasiHomeRepoImpls extends LegasiHomeRepo {
  LegasiHomeDatasource legasiHomeDatasource = LegasiHomeDatasourceImpls();

  @override
  Future<Either<Failure, LegasiHomeLoggedUserEntities>>
      firebaseLoginAndGetUserDetails(email, passwprd) async {
    try {
      final response =
          await legasiHomeDatasource.getUserDataFromFirebase(email, passwprd);
      return right(response);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(error: e.code.toString()));
    }
  }
}
