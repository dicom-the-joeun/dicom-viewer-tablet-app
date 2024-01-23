import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {
  final RxString loadingText;
  const LoadingDialog({super.key, required this.loadingText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 600,
            height: 10,
            child: LinearProgressIndicator(
              color: Color.fromARGB(255, 228, 85, 75),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              loadingText.value, // Access the value property of RxString
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
