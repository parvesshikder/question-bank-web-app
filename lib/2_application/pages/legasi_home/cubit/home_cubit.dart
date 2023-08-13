import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionbankleggasi/1_domain/failures/failures.dart';

import 'package:questionbankleggasi/1_domain/usecases/lagasi_home_usecases.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuildContext context;
  HomeCubit({
    required this.context,
  }) : super(HomeInitial());

  LegasiHomeUseCases legasiHomeUseCases = LegasiHomeUseCases();

  Future<void> logInButtobClick(
      {required String email, required String password, required String uType}) async {
    emit(HomeILoadingState());

    await Future.delayed(const Duration(seconds: 3));

    final loginReponse = await legasiHomeUseCases.logIn(email, password);
    loginReponse.fold(
      (error) async {
        emit(HomeErrorState(errorMessage: error.toString()));
      },
      (success) {
        if(success.userType == uType){
          emit(HomeMoveToAdminDashboard(
            email: success.userEmail,
            uid: success.uid,
            name: success.userName,
            userType: success.userType));
        }else{
          FirebaseAuth.instance.signOut();
          emit(HomeErrorState(errorMessage: 'Invalid User'));
        }
        
      },
    );
  }

  Future<void> regsiter(
      {required String email,
      required String password,
      required String phone,
      required String fullName,
      required String address}) async {
    emit(HomeILoadingState());

    await Future.delayed(const Duration(seconds: 3));

    final status = await legasiHomeUseCases.register(
        email, password, phone, fullName, address);

    emit(HomeRegisterVarification(status: status.toString()));
  }
}


