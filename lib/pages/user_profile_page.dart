import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:public_chat_app_flutter/auth/auth_service.dart';
import 'package:public_chat_app_flutter/providers/user_provider.dart';
import 'package:public_chat_app_flutter/widgets/main_drawer.dart';

import '../models/userModel.dart';

class UserProfilePage extends StatefulWidget {
  static const String routeName= '/profile';
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  final txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, provider, _) => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: provider.getUserByUid(AuthService.user!.uid),
            builder: (context, snapshot) {
                if(snapshot.hasData){
                  final userModel = UserModel.fromMap(snapshot.data!.data()!);
                  return ListView(
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: userModel.image == null ?
                        Image.asset(
                          'images/user.png',
                          width:  100,
                          height:  100,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          userModel.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      TextButton.icon(
                          onPressed: _updateImage,
                          icon: const Icon(Icons.camera),
                          label: const Text('Upload Image')
                      ),
                      const Divider(color: Colors.white54, height: 1,),
                      ListTile(
                        title: Text(userModel.name ?? 'No Display Name'),
                        trailing: IconButton(
                          icon:  const Icon(Icons.edit),
                          onPressed: () {
                            showInputDialog('Display Name', userModel.name, (value) async {
                              await provider.updateProfile(AuthService.user!.uid, {'name' : value});
                              await AuthService.updateDisplayName(value);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.mobile ?? 'No Mobile Number'),
                        trailing: IconButton(
                          icon:  const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                      ListTile(
                        title: Text(userModel.email ?? 'No Email Address'),
                        trailing: IconButton(
                          icon:  const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                }
                if(snapshot.hasError) {
                  return const Text('Failed to fetch data');
                }
                return const CircularProgressIndicator();
            },
          )
        ),
      ),
    );
  }

  void _updateImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 75);
    if(xFile != null) {
      try {
        final downloadUrl = await Provider
            .of<UserProvider>(context, listen: false).updateImage(xFile);
        await Provider
            .of<UserProvider>(context, listen: false).updateProfile(AuthService.user!.uid,
            {'image' : downloadUrl});
        await AuthService.updateDisplayImage(downloadUrl);

      } catch(e) {
        rethrow;
      }
    }
  }

  showInputDialog(String title, String? value, Function(String) onSaved) {
    txtController.text = value ?? '';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtController,
              decoration: InputDecoration(
                hintText: 'Enter $title'
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                onSaved(txtController.text);
                Navigator.pop(context);
              }, child: const Text('UPDATE'),
            ),
          ],
            ));
  }
}
