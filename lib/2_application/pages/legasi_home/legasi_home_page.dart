import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/admin/navbar/admin_navbar.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_initial_view.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/navbar/question_maker_navbar.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/navbar/question_taker_navbar.dart';

class LegasiHomePage extends StatefulWidget {
  @override
  _LegasiHomePageState createState() => _LegasiHomePageState();
}

class _LegasiHomePageState extends State<LegasiHomePage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Your decoration
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // Your state handling logic
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
                return const QuestionTakerNavbar();
              } else if (state.userType == 'questionMaker') {
                return const QuestionMakerNavbar();
              } else if (state.userType == 'admin') {
                return const AdminNavbar();
              } else {
                return HomeInitialView(
                  deviceWidth: deviceWidth,
                  runInvalidLogIn: true,
                  error: 'Invalid User',
                );
              }
            } else if (state is HomeErrorState) {
              return HomeInitialView(
                deviceWidth: deviceWidth,
                runInvalidLogIn: true,
                error: state.errorMessage,
              );
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
