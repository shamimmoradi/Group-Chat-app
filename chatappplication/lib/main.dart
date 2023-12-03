import 'package:chatapplication/bindings/init_binding.dart';
import 'package:chatapplication/pages/login_page.dart';
import 'package:chatapplication/pages/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';

import 'pages/home_page.dart'; // For jsonDecode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  print(theme);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp( MyApp(theme: theme));
}



class MyApp extends StatelessWidget {
    final ThemeData? theme;
const MyApp({Key? key,  this.theme}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: theme,
      title: 'messanger-app',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      getPages: [
        GetPage(name: Routes.SPLASH_SCREEN, page: () =>  const LoginPage() , ),
        GetPage(name: Routes.PROFILE, page: () =>  const UserInfoScreen() , ),
        GetPage(name: Routes.DASHBOARD, page: () =>  const HomePage() , ),
      ],
      initialRoute: Routes.SPLASH_SCREEN ,
      // home: const LoginPage(),
    );
  }
}

class Routes {
  static const String SPLASH_SCREEN = '/';
  static const String PROFILE = '/profile';
  static const String DASHBOARD = "/dashboard";
}
