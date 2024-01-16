import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget MyAppBar({required String title, List<Widget>? actions}) =>
    AppBar(
      iconTheme: const IconThemeData(
        size: 30,
      ),
      toolbarHeight: 70,
      backgroundColor: Colors.black,
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: actions,
    );
