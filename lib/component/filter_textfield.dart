import 'package:flutter/material.dart';

class FiterTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const FiterTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 150,
          height: 35,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: labelText),
          ),
        ),
      );
}
