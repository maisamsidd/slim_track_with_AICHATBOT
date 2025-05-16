import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:silm_track_app_new/Model/UserModel.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;

  static String get userId => user.uid;
  static Future<bool> userExist() async {
    return (await firestore.collection("user").doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = UserModel(
      image: user.photoURL.toString(),
      name: user.displayName.toString(),
      about: "Hey I am using Happy Chat",
      createdAt: time,
      isOnline: false,
      lastActive: time,
      id: user.uid,
      email: user.email.toString(),
      pushToken: "",
    );
    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(chatUser.toJson());
  }
}
