import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:questionbankleggasi/0_data/models/legasi_home_logged_user_model.dart';

abstract class LegasiHomeDatasource {
  Future<LegasiHomeLoggedUserModel> getUserDataFromFirebase(
      String email, String password);

  Future<String> getUserDataFromFirebaseAfterRegisterNewAC(String email,
      String password, String phone, String fullName, String address);
}

class LegasiHomeDatasourceImpls extends LegasiHomeDatasource {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

@override
Future<LegasiHomeLoggedUserModel> getUserDataFromFirebase(
    String email, String password) async {
  try {
    // Sign in user
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userCredential = _firebaseAuth.currentUser;

    if (userCredential != null) {
      // Retrieve user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await _firebaseFirestore
              .collection('users')
              .doc(userCredential.uid)
              .get();

      if (userDocument.exists) {
        Map<String, dynamic> userData = userDocument.data()!;
        
        return LegasiHomeLoggedUserModel.fromJson(userData);
      } else {
        throw Exception('User data not found in Firestore');
      }
    } else {
      throw Exception('User is not authenticated');
    }
  } catch (e) {
    // Handle any exceptions
    throw e;
  }
}

  @override
  Future<String> getUserDataFromFirebaseAfterRegisterNewAC(
    String email,
    String password,
    String phone,
    String fullName,
    String address,
  ) async {
    String status = '';
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userCredential = _firebaseAuth.currentUser;
      if (userCredential != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.uid)
            .set({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'address': address,
          'userType': 'public',
          'uid' : userCredential.uid,
        });

        // Send email verification
        await userCredential.sendEmailVerification();

        status = 'New Account Created. Verification email sent.';
      } else {
        status = 'User creation failed';
      }
    } on FirebaseException catch (e) {
      status = e.toString();
    }
    return status;
  }
}
