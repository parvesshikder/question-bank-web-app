import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/admin/admin_dashboard.dart';
import 'package:questionbankleggasi/2_application/pages/admin/navbar/admin_navbar.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_initial_view.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/question_maker_dashboard.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/question_taker_dahboard.dart';

class LegasiHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return HomeInitialView(
                deviceWidth: deviceWidth,
                runInvalidLogIn: false,
              );
            } else if (state is HomeILoadingState) {
              return Center(
                child: Lottie.asset(loading, height: 200, width: 200),
              );
            } else if (state is HomeMoveToAdminDashboard) {
              
              if (state.userType == 'public') {
                return const QuestionTakerDashboard();
              } else if (state.userType == 'questionMaker') {
                return const QuestionMakerDashboard();
              } else if (state.userType == 'admin') {
                return const AdminNavbar();
              } else {
                return HomeInitialView(
                    deviceWidth: deviceWidth,
                    runInvalidLogIn: true,
                    error: 'Invalid User');
              }
            } else if (state is HomeErrorState) {
              return HomeInitialView(
                  deviceWidth: deviceWidth,
                  runInvalidLogIn: true,
                  error: state.errorMesssage);
            } else if (state is HomeRegisterVarification) {
              return HomeInitialView(
                deviceWidth: deviceWidth,
                runInvalidLogIn: true,
                status: state.status,
              );
            } else {
              return const Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
