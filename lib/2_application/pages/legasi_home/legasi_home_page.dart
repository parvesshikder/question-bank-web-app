import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/admin/admin_dashboard.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/widget/home_initial_view.dart';

class LegasiHomePage extends StatelessWidget {
  LegasiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
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
              return SizedBox(
                  height: 40,
                  width: 40,
                  child: Lottie.asset(loading, height: 40, width: 40));
            } else if (state is HomeMoveToAdminDashboard) {
              return const AdminDashboard();
            } else if (state is HomeErrorState) {
              return HomeInitialView(
                deviceWidth: deviceWidth,
                runInvalidLogIn: true,
                error: state.errorMesssage,
              );

              //LegasiHomeError(state.errorMesssage).showSnakbarLegasiHome(context);
            } else {
              return const Text(
                'Error',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }
}
