import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';
import 'package:questionbankleggasi/wrapper.dart';

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
  runApp(LegasiQuestionBank());
}

class LegasiQuestionBank extends StatefulWidget {
  const LegasiQuestionBank({super.key});

  @override
  State<LegasiQuestionBank> createState() => _LegasiQuestionBankState();
}

class _LegasiQuestionBankState extends State<LegasiQuestionBank> {
  final Future<FirebaseApp> _initiData = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initiData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Snapshort has Error'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            initialData: FirebaseAuth.instance.currentUser,
            value: FirebaseAuth.instance.authStateChanges(),
            child: const Wrapper(),
          );
        }

        return Lottie.asset(loading, height: 200, width: 200);
      },
    );
  }
}
