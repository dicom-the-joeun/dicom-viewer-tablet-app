
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget MyAppBar({required String title, List<Widget>? actions, PreferredSizeWidget? bottom}) =>
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
      bottom: bottom,
    );
    
// ignore: non_constant_identifier_names
PreferredSizeWidget MyHomeAppBar({required String title, required String logoPath, List<Widget>? actions, PreferredSizeWidget? bottom}) =>
    AppBar(
      iconTheme: const IconThemeData(
        size: 30,
      ),
      toolbarHeight: 70,
      backgroundColor: Colors.black,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: Image.asset(logoPath),
              ),
              SizedBox(width: 10,),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: actions,
      bottom: bottom,
    );
