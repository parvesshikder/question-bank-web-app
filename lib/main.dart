import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/cubit/home_cubit.dart';
import 'package:questionbankleggasi/2_application/pages/legasi_home/legasi_home_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDWu6wUE6-EDXVsdpyj6Cjl394R0_STmns",
        authDomain: "questionbanklegasi.firebaseapp.com",
        projectId: "questionbanklegasi",
        storageBucket: "questionbanklegasi.appspot.com",
        messagingSenderId: "408799635477",
        appId: "1:408799635477:web:14be005209ce779bb9061c"),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context: context),
      child: MaterialApp(
        title: 'My App',
        home: LegasiHomePage(), // Use HomePageWrapperProvider here
      ),
    );
  }
}
