import 'package:flutter/material.dart';
import 'package:public_chat_app_flutter/auth/auth_service.dart';
import 'package:public_chat_app_flutter/pages/login_page.dart';
import 'package:public_chat_app_flutter/pages/user_profile_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.user == null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
      else {
        Navigator.pushReplacementNamed(context, UserProfilePage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
