import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/2_application/pages/admin/navbar/admin_navbar.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/legasi_home_page.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/cubit/question_maker_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/questionmaker/navbar/question_maker_navbar.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/cubit/question_taker_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/questiontaker/navbar/question_taker_navbar.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final user = FirebaseAuth.instance.currentUser;
  late String currentUserType;
  bool isLoading = true;

  @override
  void initState() {
    if(user != null){
      fetchUserType();
    }else{
      currentUserType = '';
      setState(() {
        isLoading = false; // Show loading indicator
      });
    }
    
    super.initState();
  }

  Future<void> fetchUserType() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      final userData = userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        currentUserType = userData['userType'] as String;
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(context: context)),
        BlocProvider(create: (context) => QuestionTakerCubit(context: context)),
        BlocProvider(create: (context) => QuestionMakerCubit(context: context)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoading
            ? Center(
                child: Lottie.asset(loading,
                    height: 200, width: 200), // Show loading indicator
              )
            : (currentUserType == 'admin'
                ? const AdminNavbar()
                : (currentUserType == 'questionMaker'
                    ? const Scaffold(body: QuestionMakerNavbar())
                    : (currentUserType == 'public'
                        ? const Scaffold(body: QuestionTakerNavbar())
                        : LegasiHomePage()))),
      ),
    );
  }
}
