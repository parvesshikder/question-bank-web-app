import 'package:firebase_auth/firebase_auth.dart';
import 'package:questionbankleggasi/0_data/models/legasi_home_logged_user_model.dart';

abstract class LegasiHomeDatasource {
  Future<LegasiHomeLoggedUserModel> getUserDataFromFirebase(
      String email, String password);
}

class LegasiHomeDatasourceImpls extends LegasiHomeDatasource {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<LegasiHomeLoggedUserModel> getUserDataFromFirebase(
      String email, String password) async {
    //final responseBody = json.decode(userData.body);
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final userCredential = _firebaseAuth.currentUser;
    final userData = {
      'uid': userCredential!.uid.toString(),
      //'userName': userCredential.displayName,
      'userEmail': userCredential.email,
      //'userType': 'userType',
      //'paymentStatus': 'paymentStatus',
    };

    return LegasiHomeLoggedUserModel.fromJson(userData);
  }
}
