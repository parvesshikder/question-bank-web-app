// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:questionbankleggasi/1_domain/usecases/lagasi_home_usecases.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuildContext context;
  HomeCubit({
    required this.context,
  }) : super(HomeInitial());

  LegasiHomeUseCases legasiHomeUseCases = LegasiHomeUseCases();

  Future<void> logInButtobClick(
      {required String email, required String password}) async {
    emit(HomeILoadingState());

    await Future.delayed(const Duration(seconds: 3));

    final loginReponse = await legasiHomeUseCases.logIn(email, password);
    loginReponse.fold(
      (error) async {
        emit(HomeErrorState(errorMesssage: error.error.toString()));
      },
      (success) {
        emit(HomeMoveToAdminDashboard(
            email: success.userEmail, uid: success.uid));
      },
    );
  }
}
