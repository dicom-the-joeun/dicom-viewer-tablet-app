import 'package:dicom_image_control_app/view/login_view.dart';
import 'package:dicom_image_control_app/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
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
  // .env 파일 로드
  await dotenv.load();

  bool isLogin = await checkLogin();

  Widget initialScreen = (isLogin) ? const MainView() : const LoginView();

  runApp(MyApp(initialScreen: initialScreen,));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: initialScreen,
      home: const MainView(),
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