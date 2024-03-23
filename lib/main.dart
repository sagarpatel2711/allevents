import 'package:allevents/Controller/apiController.dart';
import 'package:allevents/Controller/homeController.dart';
import 'package:allevents/Routes/pages.dart';
import 'package:allevents/localization/localizationService.dart';
import 'package:allevents/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(HomeController());
  Get.put(ApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HomeView,
      getPages: Pages.routes,
      theme: Themes.lightTheme,
      // darkTheme: Themes.darkTheme,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
