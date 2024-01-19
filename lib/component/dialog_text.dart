import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogText extends StatelessWidget {
  final RxString loadingName;
  const DialogText({super.key, required this.loadingName});

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
          Obx(() => Text(
                loadingName.value, // Access the value property of RxString
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
