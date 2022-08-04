import 'package:flutter/material.dart';
import 'package:public_chat_app_flutter/auth/auth_service.dart';
import 'package:public_chat_app_flutter/pages/launcher_page.dart';
import 'package:public_chat_app_flutter/pages/login_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.greenAccent,
          ),
          ListTile(
            onTap: () async{
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          )
        ],
      ),
    );
  }
}
