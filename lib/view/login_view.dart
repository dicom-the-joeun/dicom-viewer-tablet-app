import 'package:dicom_image_control_app/component/login_textfield.dart';
import 'package:dicom_image_control_app/view/home_view.dart';
import 'package:dicom_image_control_app/view_model/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  padding: const EdgeInsets.fromLTRB(50, 8, 8, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Text(
                      loginVM.loginResultString,
                      style: const TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 246, 105, 95),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () async {
                        bool result = await loginVM.login(
                          loginVM.idController.text,
                          loginVM.pwController.text,
                        );
                        if (result == true) {
                          Get.to(() => const MainView());
                        } else {
                          Get.snackbar(
                              'ERROR', '서버와의 연결이 원활하지 않습니다. 다시 시도해 주세요.',
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                              snackPosition: SnackPosition.BOTTOM,
                              titleText: const Text('  ERROR', style: TextStyle(fontSize: 25),),
                              messageText: const Text(
                                '  서버와의 연결이 원활하지 않습니다. 다시 시도해 주세요.', 
                                style: TextStyle(fontSize: 20),),
                            );
                        }
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
