import 'package:questionbankleggasi/1_domain/entities/legasi_home_entities.dart';

class LegasiHomeLoggedUserModel extends LegasiHomeLoggedUserEntities {
  LegasiHomeLoggedUserModel({
    required String uid,
    //required String userName,
    required String userEmail,
    // required String userType,
    // required String paymentStatus
  }) : super(
          uid: uid,
          //paymentStatus: paymentStatus,
          userEmail: userEmail,
          //userName: userName,
          //  userType: userType
        );

  factory LegasiHomeLoggedUserModel.fromJson(Map<String, dynamic> json) {
    return LegasiHomeLoggedUserModel(
      uid: json['uid'],
      //userName: json['userName'],
      userEmail: json['userEmail'],
      // userType: json['userType'],
      // paymentStatus: json['paymentStatus']
    );
  }
}
