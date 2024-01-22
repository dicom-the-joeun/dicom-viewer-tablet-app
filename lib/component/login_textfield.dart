import 'package:dicom_image_control_app/view_model/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  /// 로그인 시 ID, PW에 사용될 텍스트필드 위젯
  const LoginTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    var loginVM = Get.find<LoginVM>();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: TextField(
          controller: controller,
          onChanged: (value) => loginVM.resetResultText(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon),
            prefixIconColor: Colors.black,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
