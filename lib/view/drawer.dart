import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 64, 64, 64),
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 64, 64, 64),
            ),
              currentAccountPicture: (CircleAvatar(
                // backgroundImage: AssetImage('images/doctor icon.webp'), 

              )),
              accountName: Text('닥터'),
              accountEmail: Text('pacsplus')),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('로그아웃'),
            onTap: () {
              // 로그인페이지로 이동
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
            onTap: () {
              //
            },
          ),
        ],
      ),
    );
  }
}