import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:public_chat_app_flutter/models/userModel.dart';

class DBHelper {
  static const String collectionUser = 'Users';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUser).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Stream <DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();


  static Future<void> updateProfile(String uid, Map<String, dynamic> map){
    return _db.collection(collectionUser).doc(uid).update(map);
  }
}