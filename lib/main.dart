import 'dart:io';

import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/view/login_view/login_view.dart';
import 'package:dicom_image_control_app/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // main 비동기 사용 위해
  WidgetsFlutterBinding.ensureInitialized();
  
  // portrait 제한
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
  
  
  Directory directory = await getApplicationDocumentsDirectory();
  print('path: ${directory.path}');
  filePath = directory.path;

  // .env 파일 로드
  await dotenv.load();

  bool isLogin = await checkLogin();

  Widget initialScreen = (isLogin) ? const HomeView() : const LoginView();

  runApp(MyApp(initialScreen: initialScreen,));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initialScreen,
      darkTheme: ThemeData.dark(
        useMaterial3: false
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('login_state') ?? false;
  return isLogin;
}