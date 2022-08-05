import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_chat_app_flutter/db/dbhelper.dart';

import '../models/userModel.dart';

class UserProvider extends ChangeNotifier{
  List<UserModel> userList = [];
  
  Future<void> addUser(UserModel userModel) => DBHelper.addUser(userModel);

  Stream <DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      DBHelper.getUserByUid(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DBHelper.updateProfile(uid, map);

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child('pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => const Text('Upload Complete'));
    return snapshot.ref.getDownloadURL();
  }
}