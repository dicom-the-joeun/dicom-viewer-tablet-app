import 'package:dicom_image_control_app/component/login_textfield.dart';
import 'package:dicom_image_control_app/view/main_view.dart';
import 'package:dicom_image_control_app/view_model/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginVM());
    return GetBuilder<LoginVM>(
      init: LoginVM(),
      builder: (loginVM) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.asset('assets/images/pacs.png')),
                ),
                LoginTextField(
                  controller: loginVM.idController,
                  icon: Icons.person,
                  hintText: '아이디',
                ),
                LoginTextField(
                  controller: loginVM.pwController,
                  icon: Icons.lock,
                  hintText: '비밀번호',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      onPressed: () {
                        Get.to(() => const MainView());
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
