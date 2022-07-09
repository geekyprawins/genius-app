import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user/user.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    required String userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set(
      {
        "userEmail": userEmail,
        "userUid": currentUser.uid,
      },
    );
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail").toString(),
        userUid: value.get("userUid").toString(),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}
