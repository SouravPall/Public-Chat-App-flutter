import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:public_chat_app_flutter/pages/chat_room_page.dart';
import 'package:public_chat_app_flutter/pages/launcher_page.dart';
import 'package:public_chat_app_flutter/pages/login_page.dart';
import 'package:public_chat_app_flutter/pages/user_profile_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase. initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Public Chatting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LoginPage.routeName : (_) => LoginPage(),
        UserProfilePage.routeName : (_) => UserProfilePage(),
        ChatRoomPage.routeName : (_) => ChatRoomPage(),
      },
    );
  }
}


