import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Controller/authController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Routes/pages.dart';
import 'package:allevents/localization/localizationService.dart';
import 'package:allevents/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HomeController());
  Get.put(AuthController());
  Get.put(ApiController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? appLog;

  Future<bool> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('wepokijfrhhkdmc');
    return action == null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            appLog = snapshot.data;
            return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              initialRoute:
                  appLog ?? true ? Routes.SignInView : Routes.HomeView,
              getPages: Pages.routes,
              theme: Themes.lightTheme,
              // darkTheme: Themes.darkTheme,
              locale: LocalizationService.locale,
              fallbackLocale: LocalizationService.fallbackLocale,
              translations: LocalizationService(),
            );
          }
        }
      },
    );
  }
}
