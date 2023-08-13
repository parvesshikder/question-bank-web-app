import 'package:dartz/dartz.dart';
import 'package:questionbankleggasi/1_domain/entities/legasi_home_entities.dart';
import 'package:questionbankleggasi/1_domain/failures/failures.dart';

abstract class LegasiHomeRepo {
  Future<Either<Failure, LegasiHomeLoggedUserEntities>>
      firebaseLoginAndGetUserDetails(
          String email, String password);
  Future<String> firebaseRegisterAndGetUserDetails(String email,
      String password, String phone, String fullName, String address);
}
