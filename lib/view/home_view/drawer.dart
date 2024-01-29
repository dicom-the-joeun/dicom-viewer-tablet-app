import 'package:dicom_image_control_app/view/login_view/login_view.dart';
import 'package:dicom_image_control_app/view_model/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //var loginVM = Get.lazyPut(() => LoginVM());
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
              LoginVM().logout();
              Get.to(() => const LoginView());
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